#!/usr/bin/env bash

# sudo 是一种权限管理机制，管理员可以授权普通用户去执行 root 权限的操作，而不需要知道 root 的密码。
# sudo 以其他用户身份执行命令，默认以root身份执行。配置文件/etc/sudoers，使用命令 visudo 编辑配置，配置文本行数100gg

vim /etc/sudoers

## Allow root to run any commands anywhere
root      ALL          =  (ALL)                   ALL
boy       ALL          =  (ALL)                   NOPASSWD:/bin/ls                  #允许boy用户使用ls命令，且无需输入密码
boy       ALL          =  (ALL)                   NOPASSWD:ALL                      #允许boy用户使用全部命令，且无需输入密码
# 用户 从哪些主机执行命令  =  （用户身份，默认root用户）  可使用命令的全路径格式,多个命令以逗号分隔

# sudo时间戳：普通用户第一次执行sudo命令时，需输入账户密码，系统会在/var/run/sudo/ts目录下为该用户创建时间戳，
# 有效时间5分钟，可使用-v参数延长有效期，使用-k参数清除时间戳。

# 仅允许用户 nick 在 192.168.10.0/24 网段上连接主机并且以 root 权限执行 useradd 命令
nick 192.168.10.0/24=(root) /usr/sbin/useradd


# 对/etc/sudoers检查语法
visudo -c


# sudo运行时，会默认重置环境变量为安全的环境变量，也即，但前设置的变量都会失效，只有少数配置文件中指定的环境变量能保存下来。
# 1. sudo -E
# -E选项在man page中的解释是：
# The -E (preserve environment) option indicates to the security policy that the user wishes to preserve their existing environment variables. The security policy may return an error if the -E option is specified and the user does not have permission to preserve the environment.
# 简单来说，就是加上-E选项后，用户可以在sudo执行时保留当前用户已存在的环境变量，不会被sudo重置，
# 另外，如果用户对于指定的环境变量没有权限，则会报错。
sudo -E bash test.sh       # 加上-E参数后就可以获取到变量
# 2.
vi  /etc/sudoers
# 在Defaults env_keep添加JAVA_HOME和PATH就可以继承下来已有的环境变量了。
# 3.
alias sudo='sudo env PATH=$PATH NODE_PATH=$NODE_PATH'


#ENVIRONMENT
#     sudo utilizes the following environment variables.  The security policy has control over the actual content of the com‐
#     mand's environment.
#
#     EDITOR           Default editor to use in -e (sudoedit) mode if neither SUDO_EDITOR nor VISUAL is set.
#
#     MAIL             Set to the mail spool of the target user when the -i option is specified or when env_reset is enabled
#                      in sudoers (unless MAIL is present in the env_keep list).
#
#     HOME             Set to the home directory of the target user when the -i or -H options are specified, when the -s
#                      option is specified and set_home is set in sudoers, when always_set_home is enabled in sudoers, or when
#     systems allowed setuid processes to dump core by default.  To aid in debugging sudo crashes, you may wish to re-enable
#     core dumps by setting “disable_coredump” to false in the sudo.conf(5) file as follows:
#
#           Set disable_coredump false
#
#     See the sudo.conf(5) manual for more information.
#
#ENVIRONMENT
#     sudo utilizes the following environment variables.  The security policy has control over the actual content of the com‐
#     mand's environment.
#
#     EDITOR           Default editor to use in -e (sudoedit) mode if neither SUDO_EDITOR nor VISUAL is set.
#
#     MAIL             Set to the mail spool of the target user when the -i option is specified or when env_reset is enabled
#                      in sudoers (unless MAIL is present in the env_keep list).
#
#     HOME             Set to the home directory of the target user when the -i or -H options are specified, when the -s
#                      option is specified and set_home is set in sudoers, when always_set_home is enabled in sudoers, or when
#                      env_reset is enabled in sudoers and HOME is not present in the env_keep list.
#
#     LOGNAME          Set to the login name of the target user when the -i option is specified, when the set_logname option
#                      is enabled in sudoers or when the env_reset option is enabled in sudoers (unless LOGNAME is present in
#                      the env_keep list).
#
#     PATH             May be overridden by the security policy.
#
#     SHELL            Used to determine shell to run with -s option.
#
#     SUDO_ASKPASS     Specifies the path to a helper program used to read the password if no terminal is available or if the
#                      -A option is specified.
#
#     SUDO_COMMAND     Set to the command run by sudo.
#
#     SUDO_EDITOR      Default editor to use in -e (sudoedit) mode.
#
#     SUDO_GID         Set to the group ID of the user who invoked sudo.
#
#     SUDO_PROMPT      Used as the default password prompt unless the -p option was specified.
#
#     SUDO_PS1         If set, PS1 will be set to its value for the program being run.
#
#     SUDO_UID         Set to the user ID of the user who invoked sudo.
#
#     SUDO_USER        Set to the login name of the user who invoked sudo.
#
#     USER             Set to the same value as LOGNAME, described above.
#
#     USERNAME         Same as USER.
#
#     VISUAL           Default editor to use in -e (sudoedit) mode if SUDO_EDITOR is not set.
#
#FILES
#     /etc/sudo.conf            sudo front end configuration
#
#EXAMPLES
#     Note: the following examples assume a properly configured security policy.
#

#     To get a file listing of an unreadable directory:
sudo ls /usr/local/protected

#     To list the home directory of user yaz on a machine where the file system holding ~yaz is not exported as root:
sudo -u yaz ls ~yaz

#     To edit the index.html file as user www:
sudoedit -u www ~www/htdocs/index.html

#     To edit the index.html file as user www:
sudoedit -u www ~www/htdocs/index.html

#     To view system logs only accessible to root and users in the adm group:
sudo -g adm more /var/log/syslog

#     To run an editor as jim with a different primary group:
sudoedit -u jim -g audio ~jim/sound.txt

#     To shut down a machine:
sudo shutdown -r +15 "quick reboot"

#     To make a usage listing of the directories in the /home partition.  Note that this runs the commands in a sub-shell to
#     make the cd and file redirection work.
sudo sh -c "cd /home ; du -s * | sort -rn > USAGE"


###  命令
# 查看用户sudo可使用命令
sudo -l

sudo [-bhHpV][-s ][-u <用户>][指令]
# 或
sudo [-klv]

# 参数
    -b   # 在后台执行指令。

    -h   # 显示帮助。

    -H   # 将HOME环境变量设为新身份的HOME环境变量。

    -k   # 结束密码的有效期限，也就是下次再执行sudo时便需要输入密码。

    -l   # 列出当前用户可执行与无法执行的指令。

    -p   # 改变询问密码的提示符号。

    -s   # 执行指定的shell。

    -u   # <用户> 　以指定的用户作为新的身份。若不加上此参数，则预设以root作为新的身份。

    -v   # 延长密码有效期限5分钟。

    -V   # 显示版本信息。

    -S   # 从标准输入流替代终端来获取密码




# sudo, sudoedit — execute a command as another user
sudo -h | -K | -k | -V
sudo -v [-AknS] [-a type] [-g group] [-h host] [-p prompt] [-u user]
sudo -l [-AknS] [-a type] [-g group] [-h host] [-p prompt] [-U user] [-u user] [command]
sudo [-AbEHnPS] [-a type] [-C num] [-c class] [-g group] [-h host] [-p prompt] [-r role] [-t type] [-T timeout]
  [-u user] [VAR=value] [-i | -s] [command]
sudoedit [-AknS] [-a type] [-C num] [-c class] [-g group] [-h host] [-p prompt] [-T timeout] [-u user] file ...

# DESCRIPTION
#     sudo allows a permitted user to execute a command as the superuser or another user, as specified by the security policy.
#     The invoking user's real (not effective) user ID is used to determine the user name with which to query the security
#     policy.
#
#     sudo supports a plugin architecture for security policies and input/output logging.  Third parties can develop and dis‐
#     tribute their own policy and I/O logging plugins to work seamlessly with the sudo front end.  The default security pol‐
#     icy is sudoers, which is configured via the file /etc/sudoers, or via LDAP.  See the Plugins section for more informa‐
#     tion.
#
#     The security policy determines what privileges, if any, a user has to run sudo.  The policy may require that users
#     authenticate themselves with a password or another authentication mechanism.  If authentication is required, sudo will
#     exit if the user's password is not entered within a configurable time limit.  This limit is policy-specific; the default
#     password prompt timeout for the sudoers security policy is unlimited.
#
#     Security policies may support credential caching to allow the user to run sudo again for a period of time without
#     requiring authentication.  The sudoers policy caches credentials for 15 minutes, unless overridden in sudoers(5).  By
#     running sudo with the -v option, a user can update the cached credentials without running a command.
#
#     When invoked as sudoedit, the -e option (described below), is implied.
#
#     Security policies may log successful and failed attempts to use sudo.  If an I/O plugin is configured, the running com‐
#     mand's input and output may be logged as well.
#
#     The options are as follows:

 -A, --askpass
    # Normally, if sudo requires a password, it will read it from the user's terminal.  If the -A (askpass) option
    # is specified, a (possibly graphical) helper program is executed to read the user's password and output the
    # password to the standard output.  If the SUDO_ASKPASS environment variable is set, it specifies the path to
    # the helper program.  Otherwise, if sudo.conf(5) contains a line specifying the askpass program, that value
    # will be used.  For example:

    #     # Path to askpass helper program
    #     Path askpass /usr/X11R6/bin/ssh-askpass

    # If no askpass program is available, sudo will exit with an error.

 -b, --background
    # Run the given command in the background.  Note that it is not possible to use shell job control to manipu‐
    # late background processes started by sudo.  Most interactive commands will fail to work properly in back‐
    # ground mode.

 -C num, --close-from=num
    # Close all file descriptors greater than or equal to num before executing a command.  Values less than three
    # are not permitted.  By default, sudo will close all open file descriptors other than standard input, stan‐
    # dard output and standard error when executing a command.  The security policy may restrict the user's abil‐
    # ity to use this option.  The sudoers policy only permits use of the -C option when the administrator has
    # enabled the closefrom_override option.

 -E, --preserve-env
    # Indicates to the security policy that the user wishes to preserve their existing environment variables.  The
    # security policy may return an error if the user does not have permission to preserve the environment.

 --preserve-env=list
    # Indicates to the security policy that the user wishes to add the comma-separated list of environment vari‐
    # ables to those preserved from the user's environment.  The security policy may return an error if the user
    # does not have permission to preserve the environment.

 -e, --edit
    # Edit one or more files instead of running a command.  In lieu of a path name, the string "sudoedit" is used
    # when consulting the security policy.  If the user is authorized by the policy, the following steps are
    # taken:

    # 1.   Temporary copies are made of the files to be edited with the owner set to the invoking user.

    # 2.   The editor specified by the policy is run to edit the temporary files.  The sudoers policy uses the
    #      SUDO_EDITOR, VISUAL and EDITOR environment variables (in that order).  If none of SUDO_EDITOR, VISUAL
    #      or EDITOR are set, the first program listed in the editor sudoers(5) option is used.

    # 3.   If they have been modified, the temporary files are copied back to their original location and the tem‐
    #      porary versions are removed.

    # To help prevent the editing of unauthorized files, the following restrictions are enforced unless explicitly
    # allowed by the security policy:

    # ·   Symbolic links may not be edited (version 1.8.15 and higher).

    # ·   Symbolic links along the path to be edited are not followed when the parent directory is writable by the
    #     invoking user unless that user is root (version 1.8.16 and higher).

    # ·   Files located in a directory that is writable by the invoking user may not be edited unless that user is
    #     root (version 1.8.16 and higher).

    # Users are never allowed to edit device special files.

    # If the specified file does not exist, it will be created.  Note that unlike most commands run by sudo, the
    # editor is run with the invoking user's environment unmodified.  If, for some reason, sudo is unable to
    # update a file with its edited version, the user will receive a warning and the edited copy will remain in a
    # temporary file.

 -g group, --group=group
    # Run the command with the primary group set to group instead of the primary group specified by the target
    # user's password database entry.  The group may be either a group name or a numeric group ID (GID) prefixed
    # with the ‘#’ character (e.g.  #0 for GID 0).  When running a command as a GID, many shells require that the
    # ‘#’ be escaped with a backslash (‘\’).  If no -u option is specified, the command will be run as the invok‐
    # ing user.  In either case, the primary group will be set to group.

 -H, --set-home
    # Request that the security policy set the HOME environment variable to the home directory specified by the
    # target user's password database entry.  Depending on the policy, this may be the default behavior.

 -h, --help
    # Display a short help message to the standard output and exit.

 -h host, --host=host
    # Run the command on the specified host if the security policy plugin supports remote commands.  Note that the
    # sudoers plugin does not currently support running remote commands.  This may also be used in conjunction
    # with the -l option to list a user's privileges for the remote host.

 -i, --login
    # Run the shell specified by the target user's password database entry as a login shell.  This means that
    # login-specific resource files such as .profile or .login will be read by the shell.  If a command is speci‐
    # fied, it is passed to the shell for execution via the shell's -c option.  If no command is specified, an
    # interactive shell is executed.  sudo attempts to change to that user's home directory before running the
    # shell.  The command is run with an environment similar to the one a user would receive at log in.  The
    # Command environment section in the sudoers(5) manual documents how the -i option affects the environment in
    # which a command is run when the sudoers policy is in use.

 -K, --remove-timestamp
    # Similar to the -k option, except that it removes the user's cached credentials entirely and may not be used
    # in conjunction with a command or other option.  This option does not require a password.  Not all security
    # policies support credential caching.

 -k, --reset-timestamp
    # When used without a command, invalidates the user's cached credentials.  In other words, the next time sudo
    # is run a password will be required.  This option does not require a password and was added to allow a user
    # to revoke sudo permissions from a .logout file.

    # When used in conjunction with a command or an option that may require a password, this option will cause
    # sudo to ignore the user's cached credentials.  As a result, sudo will prompt for a password (if one is
    # required by the security policy) and will not update the user's cached credentials.

    # Not all security policies support credential caching.

 -l, --list
    # If no command is specified, list the allowed (and forbidden) commands for the invoking user (or the user
    # specified by the -U option) on the current host.  A longer list format is used if this option is specified
    # multiple times and the security policy supports a verbose output format.

    # If a command is specified and is permitted by the security policy, the fully-qualified path to the command
    # is displayed along with any command line arguments.  If command is specified but not allowed, sudo will exit
    # with a status value of 1.

 -n, --non-interactive
    # Avoid prompting the user for input of any kind.  If a password is required for the command to run, sudo will
    # display an error message and exit.

 -P, --preserve-groups
    # Preserve the invoking user's group vector unaltered.  By default, the sudoers policy will initialize the
    # group vector to the list of groups the target user is a member of.  The real and effective group IDs, how‐
    # ever, are still set to match the target user.

 -p prompt, --prompt=prompt
    # Use a custom password prompt with optional escape sequences.  The following percent (‘%’) escape sequences
    # are supported by the sudoers policy:

    # %H  expanded to the host name including the domain name (on if the machine's host name is fully qualified or
    #     the fqdn option is set in sudoers(5))

    # %h  expanded to the local host name without the domain name

    # %p  expanded to the name of the user whose password is being requested (respects the rootpw, targetpw, and
    #     runaspw flags in sudoers(5))

    # %U  expanded to the login name of the user the command will be run as (defaults to root unless the -u option
    #     is also specified)

    # %u  expanded to the invoking user's login name

    # %%  two consecutive ‘%’ characters are collapsed into a single ‘%’ character

    # The custom prompt will override the default prompt specified by either the security policy or the
    # SUDO_PROMPT environment variable.  On systems that use PAM, the custom prompt will also override the prompt
    # specified by a PAM module unless the passprompt_override flag is disabled in sudoers.

 -r role, --role=role
    # Run the command with an SELinux security context that includes the specified role.

 -S, --stdin
    # Write the prompt to the standard error and read the password from the standard input instead of using the
    # terminal device.  The password must be followed by a newline character.

 -s, --shell
    # Run the shell specified by the SHELL environment variable if it is set or the shell specified by the invok‐
    # ing user's password database entry.  If a command is specified, it is passed to the shell for execution via
    # the shell's -c option.  If no command is specified, an interactive shell is executed.

 -t type, --type=type
    # Run the command with an SELinux security context that includes the specified type.  If no type is specified,
    # the default type is derived from the role.

 -U user, --other-user=user
    # Used in conjunction with the -l option to list the privileges for user instead of for the invoking user.
    # The security policy may restrict listing other users' privileges.  The sudoers policy only allows root or a
    # user with the ALL privilege on the current host to use this option.

 -T timeout, --command-timeout=timeout
    # Used to set a timeout for the command.  If the timeout expires before the command has exited, the command
    # will be terminated.  The security policy may restrict the ability to set command timeouts.  The sudoers pol‐
    # icy requires that user-specified timeouts be explicitly enabled.

 -u user, --user=user
    # Run the command as a user other than the default target user (usually root).  The user may be either a user
    # name or a numeric user ID (UID) prefixed with the ‘#’ character (e.g.  #0 for UID 0).  When running commands
    # as a UID, many shells require that the ‘#’ be escaped with a backslash (‘\’).  Some security policies may
    # restrict UIDs to those listed in the password database.  The sudoers policy allows UIDs that are not in the
    # password database as long as the targetpw option is not set.  Other security policies may not support this.

 -V, --version
    # Print the sudo version string as well as the version string of the security policy plugin and any I/O plug‐
    # ins.  If the invoking user is already root the -V option will display the arguments passed to configure when
    # sudo was built and plugins may display more verbose information such as default options.

 -v, --validate
    # Update the user's cached credentials, authenticating the user if necessary.  For the sudoers plugin, this
    # extends the sudo timeout for another 15 minutes by default, but does not run a command.  Not all security
    # policies support cached credentials.
#
#     --          The -- option indicates that sudo should stop processing command line arguments.
#
#     Environment variables to be set for the command may also be passed on the command line in the form of VAR=value, e.g.
#     LD_LIBRARY_PATH=/usr/local/pkg/lib.  Variables passed on the command line are subject to restrictions imposed by the
#     security policy plugin.  The sudoers policy subjects variables passed on the command line to the same restrictions as
#     normal environment variables with one important exception.  If the setenv option is set in sudoers, the command to be
#     run has the SETENV tag set or the command matched is ALL, the user may set variables that would otherwise be forbidden.
#     See sudoers(5) for more information.
#
#COMMAND EXECUTION
#     When sudo executes a command, the security policy specifies the execution environment for the command.  Typically, the
#     real and effective user and group and IDs are set to match those of the target user, as specified in the password data‐
#     base, and the group vector is initialized based on the group database (unless the -P option was specified).
#
#     The following parameters may be specified by security policy:
#
#     ·   real and effective user ID
#
#     ·   real and effective group ID
#
#     ·   supplementary group IDs
#
#     ·   the environment list
#
#     ·   current working directory
#
#     ·   file creation mode mask (umask)
#
#     ·   SELinux role and type
#
#     ·   scheduling priority (aka nice value)
#
#   Process model
#     When sudo runs a command, it calls fork(2), sets up the execution environment as described above, and calls the execve
#     system call in the child process.  The main sudo process waits until the command has completed, then passes the com‐
#     mand's exit status to the security policy's close function and exits.  If an I/O logging plugin is configured or if the
#     security policy explicitly requests it, a new  pseudo-terminal (“pty”) is created and a second sudo process is used to
#     relay job control signals between the user's existing pty and the new pty the command is being run in.  This extra
#     process makes it possible to, for example, suspend and resume the command.  Without it, the command would be in what
#     POSIX terms an “orphaned process group” and it would not receive any job control signals.  As a special case, if the
#     policy plugin does not define a close function and no pty is required, sudo will execute the command directly instead of
#     calling fork(2) first.  The sudoers policy plugin will only define a close function when I/O logging is enabled, a pty
#     is required, or the pam_session or pam_setcred options are enabled.  Note that pam_session and pam_setcred are enabled
#     by default on systems using PAM.
#
#   Signal handling
#     When the command is run as a child of the sudo process, sudo will relay signals it receives to the command.  The SIGINT
#     and SIGQUIT signals are only relayed when the command is being run in a new pty or when the signal was sent by a user
#     process, not the kernel.  This prevents the command from receiving SIGINT twice each time the user enters control-C.
#     Some signals, such as SIGSTOP and SIGKILL, cannot be caught and thus will not be relayed to the command.  As a general
#     rule, SIGTSTP should be used instead of SIGSTOP when you wish to suspend a command being run by sudo.
#
#     As a special case, sudo will not relay signals that were sent by the command it is running.  This prevents the command
#     from accidentally killing itself.  On some systems, the reboot(8) command sends SIGTERM to all non-system processes
#     other than itself before rebooting the system.  This prevents sudo from relaying the SIGTERM signal it received back to
#     reboot(8), which might then exit before the system was actually rebooted, leaving it in a half-dead state similar to
#     single user mode.  Note, however, that this check only applies to the command run by sudo and not any other processes
#     that the command may create.  As a result, running a script that calls reboot(8) or shutdown(8) via sudo may cause the
#     system to end up in this undefined state unless the reboot(8) or shutdown(8) are run using the exec() family of func‐
#     tions instead of system() (which interposes a shell between the command and the calling process).
#
#     If no I/O logging plugins are loaded and the policy plugin has not defined a close() function, set a command timeout or
#     required that the command be run in a new pty, sudo may execute the command directly instead of running it as a child
#     process.
#
#   Plugins
#     Plugins may be specified via Plugin directives in the sudo.conf(5) file.  They may be loaded as dynamic shared objects
#     (on systems that support them), or compiled directly into the sudo binary.  If no sudo.conf(5) file is present, or it
#     contains no Plugin lines, sudo will use the traditional sudoers security policy and I/O logging.  See the sudo.conf(5)
#     manual for details of the /etc/sudo.conf file and the sudo_plugin(5) manual for more information about the sudo plugin
#     architecture.
#
#EXIT VALUE
#     Upon successful execution of a command, the exit status from sudo will be the exit status of the program that was exe‐
#     cuted.  If the command terminated due to receipt of a signal, sudo will send itself the signal that terminated the com‐
#     mand.
#
#     Otherwise, sudo exits with a value of 1 if there is a configuration/permission problem or if sudo cannot execute the
#     given command.  In the latter case, the error string is printed to the standard error.  If sudo cannot stat(2) one or
#     more entries in the user's PATH, an error is printed to the standard error.  (If the directory does not exist or if it
#     is not really a directory, the entry is ignored and no error is printed.)  This should not happen under normal circum‐
#     stances.  The most common reason for stat(2) to return “permission denied” is if you are running an automounter and one
#     of the directories in your PATH is on a machine that is currently unreachable.
#
#SECURITY NOTES
#     sudo tries to be safe when executing external commands.
#
#     To prevent command spoofing, sudo checks "." and "" (both denoting current directory) last when searching for a command
#     in the user's PATH (if one or both are in the PATH).  Note, however, that the actual PATH environment variable is not
#     modified and is passed unchanged to the program that sudo executes.
#
#     Users should never be granted sudo privileges to execute files that are writable by the user or that reside in a direc‐
#     tory that is writable by the user.  If the user can modify or replace the command there is no way to limit what addi‐
#     tional commands they can run.
#
#     Please note that sudo will normally only log the command it explicitly runs.  If a user runs a command such as sudo su
#     or sudo sh, subsequent commands run from that shell are not subject to sudo's security policy.  The same is true for
#     commands that offer shell escapes (including most editors).  If I/O logging is enabled, subsequent commands will have
#     their input and/or output logged, but there will not be traditional logs for those commands.  Because of this, care must
#     be taken when giving users access to commands via sudo to verify that the command does not inadvertently give the user
#     an effective root shell.  For more information, please see the Preventing shell escapes section in sudoers(5).
#
#     To prevent the disclosure of potentially sensitive information, sudo disables core dumps by default while it is execut‐
#     ing (they are re-enabled for the command that is run).  This historical practice dates from a time when most operating
#     systems allowed setuid processes to dump core by default.  To aid in debugging sudo crashes, you may wish to re-enable
#     core dumps by setting “disable_coredump” to false in the sudo.conf(5) file as follows:
#
#           Set disable_coredump false
#
#     See the sudo.conf(5) manual for more information.
#