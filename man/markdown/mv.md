## mv命令
mv命令是move的缩写，可以用来移动文件或者将文件改名（move (rename) files），
是Linux系统下常用的命令，经常用来备份文件或者目录。

1. 命令格式：

        mv [选项] 源文件或目录 目标文件或目录
2. 命令功能：

        视mv命令中第二个参数类型的不同（是目标文件还是目标目录），mv命令将文件重命名或将其移至一个新的目录中。
        当第二个参数类型是文件时，mv命令完成文件重命名，此时，源文件只能有一个（也可以是源目录名），
        它将所给的源文件或目录重命名为给定的目标文件名。当第二个参数是已存在的目录名称时，源文件或目录参数可以有多个，
        mv命令将各参数指定的源文件均移至目标目录中。在跨文件系统移动文件时，mv先拷贝，再将原有文件删除，而链至该文件的链接也将丢失。
3. 命令参数：

        -b ：若需覆盖文件，则覆盖前先行备份。
        -f ：force 强制的意思，如果目标文件已经存在，不会询问而直接覆盖；
        -i ：若目标文件 (destination) 已经存在时，就会询问是否覆盖！
        -u ：若目标文件已经存在，且 source 比较新，才会更新(update)
        -t  ： --target-directory=DIRECTORY move all SOURCE arguments into DIRECTORY，即指定mv的目标目录，
        该选项适用于移动多个源文件到一个目录的情况，此时目标目录在前，源文件在后。

4. 命令实例：

* 实例一：文件改名

        命令：mv test.log test1.txt

* 实例二：移动文件

        命令：mv test1.txt test3

        说明：将test1.txt文件移到目录test3中
* 实例三：将文件log1.txt,log2.txt,log3.txt移动到目录test3中。

        命令：mv log1.txt log2.txt log3.txt test3
        mv -t /opt/soft/test/test4/ log1.txt log2.txt log3.txt

        说明：mv log1.txt log2.txt log3.txt test3 命令将log1.txt ，log2.txt， log3.txt 三个文件移到 test3目录中去，
        mv -t /opt/soft/test/test4/ log1.txt log2.txt log3.txt 命令又将三个文件移动到test4目录中去

* 实例四：将文件file1改名为file2，如果file2已经存在，则询问是否覆盖

        命令：mv -i log1.txt log2.txt

* 实例五：将文件file1改名为file2，即使file2存在，也是直接覆盖掉。

        命令：mv -f log3.txt log2.txt

* 实例六：目录的移动

        命令：mv dir1 dir2

        说明：如果目录dir2不存在，将目录dir1改名为dir2；否则，将dir1移动到dir2中。

* 实例7：移动当前文件夹下的所有文件到上一级目录

        命令：mv * ../

* 实例八：把当前目录的一个子目录里的文件移动到另一个子目录里

        命令：mv test3/*.txt test5

* 实例九：文件被覆盖前做简单备份，前面加参数-b

        命令：mv log1.txt -b log2.txt

        说明：
        -b 不接受参数，mv会去读取环境变量VERSION_CONTROL来作为备份策略。
        --backup该选项指定如果目标文件存在时的动作，共有四种备份策略：
        1.CONTROL=none或off : 不备份。
        2.CONTROL=numbered或t：数字编号的备份
        3.CONTROL=existing或nil：如果存在以数字编号的备份，则继续编号备份m+1...n：
        执行mv操作前已存在以数字编号的文件log2.txt.~1~，那么再次执行将产生log2.txt~2~，以次类推。如果之前没有以数字编号的文件，则使用下面讲到的简单备份。
        4.CONTROL=simple或never：使用简单备份：在被覆盖前进行了简单备份，简单备份只能有一份，再次被覆盖时，简单备份也会被覆盖。