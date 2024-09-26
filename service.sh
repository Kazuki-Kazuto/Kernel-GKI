#!/system/bin/sh
# Do NOT assume where your module will be located.
# ALWAYS use $MODDIR if you need to know where this script
# and module is placed.
# This will make sure your module will still work
# if Magisk change its mount point in the future
MODDIR=${0%/*}
# This script will be executed in late_start service mode
#!/system/bin/sh

# ~
echo 0 >/sys/kernel/printk_mode/printk_mode
echo 0 >/proc/sys/kernel/panic
echo 0 >/proc/sys/kernel/panic_on_oops
echo 0 >/proc/sys/kernel/panic_on_rcu_stall
echo 0 >/proc/sys/kernel/panic_on_warn
echo "0 0 0 0" > /proc/sys/kernel/printk
echo "0" > /proc/sys/kernel/panic
echo "0" > /proc/sys/kernel/panic_on_oops
echo "0" > /proc/sys/kernel/perf_cpu_time_max_percent
echo "0" > /proc/sys/kernel/sched_tunable_scaling
echo 0 >/sys/module/kernel/parameters/panic
echo 0 >/sys/module/kernel/parameters/panic_on_warn
echo 0 >/sys/module/kernel/parameters/panic_on_oops
echo "0" > /proc/perfmgr/syslimiter/syslimiter_fps_60
echo "0" > /proc/perfmgr/syslimiter/syslimiter_fps_120
echo "0" > /proc/perfmgr/syslimiter/syslimiter_fps_144
echo "0" > /proc/perfmgr/syslimiter/syslimiter_tolerance_percent
echo "0" > /proc/perfmgr/syslimiter/syslimiter_fps_90
echo "0" > /proc/perfmgr/syslimiter/syslimiter_limit_freq
# ~
echo 1 > /sys/devices/system/cpu/perf/enable
# ~
echo 0 > /sys/kernel/oppo_display/LCM_CABC
# ~
echo 0 > /sys/kernel/ccci/debug
# ~
for i in /sys/block/*/queue/iostats; do
  echo "0" > "$i"
done
# ~
chmod 0644 /sys/devices/system/cpu/cpufreq/policy*/scaling_governor
restorecon -R /sys/devices/system/cpu
echo "performance" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
echo "performance" > /sys/devices/system/cpu/cpufreq/policy6/scaling_governor 
# ~
echo '0' > /sys/devices/system/cpu/isolated
echo '0' > /sys/devices/system/cpu/offline
echo '0' > /sys/devices/system/cpu/uevent
echo '1' > /sys/devices/system/cpu/cpufreq/policy0/schedutil/iowait_boost_enable
echo '1' > /sys/devices/system/cpu/cpufreq/policy4/schedutil/iowait_boost_enable
echo '1' > /sys/devices/system/cpu/sched/cpu_prefer
# ~
for i in /sys/block/*/queue/scheduler; do
  echo "noop" > "$i"
done

chmod 0444 /dev/stune/foreground/*
chmod 0444 /proc/cpufreq/*
echo '35' > /dev/stune/foreground/schedtune.boost
echo '1' > /proc/cpufreq/cpufreq_cci_mode
# ~
echo 3 >/proc/sys/vm/drop_caches
echo 20 >/proc/sys/vm/dirty_background_ratio
echo 0 >/proc/sys/vm/page-cluster
echo 10 >/proc/sys/vm/dirty_ratio
# ~
resetprop -n debug.sf.high_fps_early_phase_offset_ns 6100000
resetprop -n debug.sf.high_fps_late_app_phase_offset_ns 100000
resetprop -n debug.sf.phase_offset_threshold_for_next_vsync_ns 6100000
# ~
resetprop -n debug.sf.early_app_phase_offset_ns 500000
resetprop -n debug.sf.early_gl_app_phase_offset_ns 15000000
resetprop -n debug.sf.early_gl_phase_offset_ns 3000000
resetprop -n debug.sf.early_phase_offset_ns 500000
resetprop -n debug.sf.high_fps_early_gl_phase_offset_ns 650000
ro.tran_low_battery_60hz_refresh_rate.support=0