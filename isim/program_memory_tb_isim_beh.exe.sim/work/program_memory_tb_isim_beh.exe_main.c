/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    xilinxcorelib_ver_m_04284627112054182733_3743172433_init();
    xilinxcorelib_ver_m_18166792875774041790_2444198090_init();
    xilinxcorelib_ver_m_17738287534884592592_4081498712_init();
    xilinxcorelib_ver_m_10066368518302646626_2821436640_init();
    work_m_05240187959938530918_0396624993_init();
    work_m_03790076172556898490_2752325160_init();
    work_m_07733892826000971672_3589117894_init();
    work_m_16541823861846354283_2073120511_init();


    xsi_register_tops("work_m_07733892826000971672_3589117894");
    xsi_register_tops("work_m_16541823861846354283_2073120511");


    return xsi_run_simulation(argc, argv);

}
