    %let pgm=utl-altair-slc-identify-the-convex-polygon-that-encompasses-two-dimensional-scatter-plot;

    %stop_submission;

    Altair slc identify the convex polygon that encomapasses a two dimensional scatter plot

    Graphic output
    https://github.com/rogerjdeangelis/utl-altair-slc-identify-the-convex-polygon-that-encompasses-two-dimensional-scatter-plot/blob/main/convex_hull.png

    Too long to post on a list, see github
    https://github.com/rogerjdeangelis/utl-altair-slc-identify-the-convex-polygon-that-encompasses-two-dimensional-scatter-plot

    PROBLEM

             -2               0               2       BOUNDARY POINTS(for attached plot)
            -+---------------+---------------+-
            | Identify the points that make up|       WORKX.WANT tota
            | the encompassing convex hull    |            X           Y
          2 +                                 +
            |      .-------.                  |         1.66283    -0.20944
            |     / .    .. \                 |         0.98200    -1.19129
            |    /    .  .   \                |        -0.06057    -1.82914
            |   /   ... .. .. \.-------.      |        -0.64152    -1.52643
            | ./..   .  ...............\      |        -1.33383    -0.74963
            |  \ .... .. ......... ..   .     |        -1.65673     0.15090
          0 +   \     ..  ..... ..  . . /     +        -1.74895     0.56657
            |    \.   .. ......    ..../      |        -0.96361     1.26744
            |     \  . ... ...  .    ./       |        -0.54490     1.59209
            |      \ ...          .. /        |         0.52215     1.68854
            |       \..           ../         |         0.81345     1.50988
            |        .-------------/          |         0.99525     1.36038
            |                                 |         1.66283    -0.20944
          2 +                                 +
            -+---------------+---------------+-
            -2               0               2

                             X
    /*                   _
    (_)_ __  _ __  _   _| |_
    | | `_ \| `_ \| | | | __|
    | | | | | |_) | |_| | |_
    |_|_| |_| .__/ \__,_|\__|
            |_|
    */

    libname workx "d:/wpswrkx"; /*--- put this in your autoexec ---*/

    options validvarname=v7;
    data workx.have;
      call streaminit(1234);
      do rec=1 to 100;
         x=rand('normal');
         y=rand('normal');
         if round(x**2 + y**2) <= 3 then output;
      end;
      drop rec;
    run;quit;


    /**************************************************************************************************************************/
    /*  WORKX.HAVE total obs=100                                         X                                                    */
    /*                                      -2            -1             0             1             2                        */
    /*  Obs        x           y           --+-------------+-------------+-------------+-------------+--                      */
    /*                                   y |                                                           |  y                   */
    /*    1     0.86503     0.81118      2 +                                                           +  2                   */
    /*    2    -1.04436    -1.05649        |                                                           |                      */
    /*    3    -1.74895     0.56657        |                     *              *   *                  |                      */
    /*    4    -1.46444     0.26030        |                       *  *                *               |                      */
    /*    5    -0.65384     0.41714        |                *          *                               |                      */
    /*    ...                            1 +                                 *         **              +  1                   */
    /*  810     0.37983     0.95482        |                *       *          *     *                 |                      */
    /*  811    -0.78835    -1.31579        |     *       *      *    *   *  *** *    * *               |                      */
    /*  812    -1.33837     0.29915        |        *           *    ** ** * *     *                   |                      */
    /*  813    -0.76568    -0.48238        |      * *      * *   * * *  *                              |                      */
    /*  814     0.02972    -0.41559      0 +                    *  *        *     *                    +  0                   */
    /*                                     |               *     ***                *  *        *      |                      */
    /*                                     |             * ***  *                  *                   |                      */
    /*                                     |                        ** *             ***               |                      */
    /*                                     |          *             *                                  |                      */
    /*                                  -1 +             **       *       *                            + -1                   */
    /*                                     |                                           *               |                      */
    /*                                     |                            *           *                  |                      */
    /*                                     |                    *          *                           |                      */
    /*                                     |                            *                              |                      */
    /*                                  -2 +                                                           + -2                   */
    /*                                     |                                                           |                      */
    /*                                     --+-------------+-------------+-------------+-------------+--                      */
    /*                                      -2            -1             0             1             2                        */
    /*                                                                   X                                                    */
    /*                                                                                                                        */
    /**************************************************************************************************************************/

    %utlfkil(d:/png/d:/png/convex_hull.png);

    options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";
    proc r;
    export data=workx.have r=have;
    submit;
    png(file="d:/png/convex_hull.png");
    plot(have, cex = 0.5);
    hpts <- chull(have);
    hpts <- c(hpts, hpts[1]);
    lines(have[hpts, ]);
    want <- have[hpts,];
    dev.off();
    endsubmit;
    import r=want  data=workx.want;
    run;quit;

    /**************************************************************************************************************************/
    /* d:/pdf/convex_hull.pdf                                                                                                 */
    /*                                                                                                                        */
    /* BOUNDARY POINTS(for attached plot)                                                                                     */
    /*                                                                                                                        */
    /* WORKX.WANT tota                                                                                                        */
    /*      X           Y                                                                                                     */
    /*                                                                                                                        */
    /*   1.66283    -0.20944                                                                                                  */
    /*   0.98200    -1.19129                                                                                                  */
    /*  -0.06057    -1.82914                                                                                                  */
    /*  -0.64152    -1.52643                                                                                                  */
    /*  -1.33383    -0.74963                                                                                                  */
    /*  -1.65673     0.15090                                                                                                  */
    /*  -1.74895     0.56657                                                                                                  */
    /*  -0.96361     1.26744                                                                                                  */
    /*  -0.54490     1.59209                                                                                                  */
    /*   0.52215     1.68854                                                                                                  */
    /*   0.81345     1.50988                                                                                                  */
    /*   0.99525     1.36038                                                                                                  */
    /*   1.66283    -0.20944                                                                                                  */
    /**************************************************************************************************************************/

    /*              _
      ___ _ __   __| |
     / _ \ `_ \ / _` |
    |  __/ | | | (_| |
     \___|_| |_|\__,_|

    */

