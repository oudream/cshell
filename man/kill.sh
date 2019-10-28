#!/usr/bin/env bash

kill -9 $PID
### kill[参数][进程号]
# 不指定型号将发送SIGTERM（15）终止指定进程。
# 如果任无法终止该程序可用“-KILL” 参数，其发送的信号为SIGKILL(9) ，将强制结束进程，使用ps命令或者jobs 命令可以查看进程号。
# root用户将影响用户的进程，非root用户只能影响自己的进程。

# -l  信号，若果不加信号的编号参数，则使用“-l”参数会列出全部的信号名称
# -a  当处理当前进程时，不限制命令名和进程号的对应关系
# -p  指定kill 命令只打印相关进程的进程号，而不发送任何信号
# -s  指定发送信号
# -u  指定用户

kill -2 123

# 实例1：列出所有信号名称
kill -l


First the signals described in the original POSIX.1-1990 standard.

   Signal     Value     Action   Comment
#   ──────────────────────────────────────────────────────────────────────
   SIGHUP        1       Term    Hangup detected on controlling terminal
                                 or death of controlling process
   SIGINT        2       Term    Interrupt from keyboard
   SIGQUIT       3       Core    Quit from keyboard
   SIGILL        4       Core    Illegal Instruction
   SIGABRT       6       Core    Abort signal from abort(3)
   SIGFPE        8       Core    Floating point exception
   SIGKILL       9       Term    Kill signal
   SIGSEGV      11       Core    Invalid memory reference
   SIGPIPE      13       Term    Broken pipe: write to pipe with no
                                 readers
   SIGALRM      14       Term    Timer signal from alarm(2)
   SIGTERM      15       Term    Termination signal
   SIGUSR1   30,10,16    Term    User-defined signal 1
   SIGUSR2   31,12,17    Term    User-defined signal 2
   SIGCHLD   20,17,18    Ign     Child stopped or terminated
   SIGCONT   19,18,25    Cont    Continue if stopped
   SIGSTOP   17,19,23    Stop    Stop process
   SIGTSTP   18,20,24    Stop    Stop typed at terminal
   SIGTTIN   21,21,26    Stop    Terminal input for background process
   SIGTTOU   22,22,27    Stop    Terminal output for background process

   The signals SIGKILL and SIGSTOP cannot be caught, blocked, or ignored.

   Next  the  signals  not  in  the POSIX.1-1990 standard but described in
   SUSv2 and POSIX.1-2001.

   Signal       Value     Action   Comment
#   ────────────────────────────────────────────────────────────────────
   SIGBUS      10,7,10     Core    Bus error (bad memory access)
   SIGPOLL                 Term    Pollable event (Sys V).
                                   Synonym for SIGIO
   SIGPROF     27,27,29    Term    Profiling timer expired
   SIGSYS      12,31,12    Core    Bad argument to routine (SVr4)
   SIGTRAP        5        Core    Trace/breakpoint trap
   SIGURG      16,23,21    Ign     Urgent condition on socket (4.2BSD)
   SIGVTALRM   26,26,28    Term    Virtual alarm clock (4.2BSD)
   SIGXCPU     24,24,30    Core    CPU time limit exceeded (4.2BSD)
   SIGXFSZ     25,25,31    Core    File size limit exceeded (4.2BSD)

   Up to and including Linux 2.2, the default behavior for  SIGSYS,  SIGX‐
   CPU,  SIGXFSZ,  and (on architectures other than SPARC and MIPS) SIGBUS
   was to terminate the process (without a core  dump).   (On  some  other
   UNIX systems the default action for SIGXCPU and SIGXFSZ is to terminate
   the  process  without  a  core  dump.)   Linux  2.4  conforms  to   the
   POSIX.1-2001  requirements  for  these signals, terminating the process
   with a core dump.

   Next various other signals.

   Signal       Value     Action   Comment
#   ────────────────────────────────────────────────────────────────────
   SIGIOT         6        Core    IOT trap. A synonym for SIGABRT
   SIGEMT       7,-,7      Term
   SIGSTKFLT    -,16,-     Term    Stack fault on coprocessor (unused)
   SIGIO       23,29,22    Term    I/O now possible (4.2BSD)
   SIGCLD       -,-,18     Ign     A synonym for SIGCHLD
   SIGPWR      29,30,19    Term    Power failure (System V)
   SIGINFO      29,-,-             A synonym for SIGPWR
   SIGLOST      -,-,-      Term    File lock lost (unused)
   SIGWINCH    28,28,20    Ign     Window resize signal (4.3BSD, Sun)
   SIGUNUSED    -,31,-     Core    Synonymous with SIGSYS

   (Signal 29 is SIGINFO / SIGPWR on an alpha but SIGLOST on a sparc.)

   SIGEMT is not specified in POSIX.1-2001, but  nevertheless  appears  on
   most  other UNIX systems, where its default action is typically to ter‐
   minate the process with a core dump.

   SIGPWR (which is not specified in POSIX.1-2001) is typically ignored by
   default on those other UNIX systems where it appears.

   SIGIO (which is not specified in POSIX.1-2001) is ignored by default on
   several other UNIX systems.

   Where defined, SIGUNUSED is synonymous with SIGSYS  on  most  architec‐
   tures.