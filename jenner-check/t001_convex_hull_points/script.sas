/* Adapted from utl-altair-slc-identify-the-convex-polygon-that-encompasses-two-dimensional-scatter-plot.sas
   Original script writes to an external libname (workx, mapped to d:/wpswrkx) and then
   hands the generated points off to PROC R (chull()) to find the convex hull boundary.
   This bundle keeps the point-generation DATA step byte-for-byte (same streaminit seed,
   same accept/reject circle test) and drops the external-R leg, which depends on a local
   R install and Windows paths and isn't something a hosted engine can reach. WORK is used
   in place of the external LIBNAME WORKX. */

options validvarname=v7;
data have;
  call streaminit(1234);
  do rec=1 to 100;
     x=rand('normal');
     y=rand('normal');
     if round(x**2 + y**2) <= 3 then output;
  end;
  drop rec;
run;

proc print data=have noobs;
  var x y;
  title "Scatter plot source data (points within radius^2<=3 of origin)";
run;

proc means data=have n mean std min max;
  var x y;
  title "Summary of generated scatter-plot points";
run;
