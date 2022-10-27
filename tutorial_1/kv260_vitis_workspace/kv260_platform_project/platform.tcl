# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/shareefj/git/kv260_tutorial/tutorial_1/kv260_vitis_workspace/kv260_platform_project/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/shareefj/git/kv260_tutorial/tutorial_1/kv260_vitis_workspace/kv260_platform_project/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {kv260_platform_project}\
-hw {/home/shareefj/git/kv260_tutorial/tutorial_1/kv260_hardware_platform/vivado_project/kv260_psu_wrapper.xsa}\
-proc {psu_cortexa53} -os {linux} -arch {64-bit} -no-boot-bsp -fsbl-target {psu_cortexa53_0} -out {/home/shareefj/git/kv260_tutorial/tutorial_1/kv260_vitis_workspace}

platform write
platform active {kv260_platform_project}
platform generate
