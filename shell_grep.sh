正则就是有一定规律的字符串，不仅可以使用命令行工具grep， sed，awk ，egrep去引用正则，还可以把正则嵌入到 nginx，apache，甚至php，python中。特殊符号（. * + ? |）
grep，主要用来过滤出指定的行。指定的条件，用正则表达式。

1、语法选项
grep [-civnABC] 'word' filename
-n 在输出符合要求的行的同时，连同行号一起输出
-c 打印符合要求的行数
-v 打印不符合要求的行
--color 匹配到的关键字用红色标识
-A 后跟一个数字，空格可有可无，-A2 表示打印符合要求的行以及下面两行
-B 后跟一个数字，-B2 表示打印符合要求的行以及上面两行
-C 后跟一个数字，-C2 表示打印符合要求的行以及上下各两行
-r 把目录下面所有的文件全部遍历 【不是很常用】
-i 不区分大小写
-E 脱意字符\的作用
#grep -r "iptables" /etc/* 显示该目录下所有包含该字符的信息，包含文件路径
#grep -rh "iptables" /etc/* 不显示文件路径，直接显示结果

2、例子介绍
#alias grep='grep --color'
#cp /etc/passwd 1.txt
#grep '[cnsoe]' 1.txt 取其中任意一个进行匹配，匹配cnsoe中的任何一个
#grep '[0-9]' 1.txt 匹配包含任意数字
#grep '[^0-9]' 1.txt 匹配包含非数字的行，某行有数字，字母，特殊字符，也会显示出来。
#grep '^[0-9]' 1.txt 取数字开头的行
#grep -v '[0-9]' 1.txt 匹配不包含数字的行，可匹配空行，特殊字符
#grep -v '^[0-9]' 1.txt 匹配非0-9开头的行，可匹配空行，特殊字符
#grep '^[^0-9]' 1.txt 取不以数字开头的行，可匹配特殊符号，不包括空行
#grep '^$' 1.txt 取空行，不包含任何字符的行，空格也算特殊字符
#grep '[^a-zA-Z]' 匹配包含非字母的行，并非全部都没有字母，只要含有非字母都可以
#grep '^[1-9][0-9]*$' 1.txt：匹配开头为1到9其中一个数字，结尾是0个或多个数字 ？？？？？
'r.o' .表示任意一个字符，包括特殊符号。
'r\?o' ?表示零个或一个？前面的字符；匹配出的结果又 roo ，r\?o中表示匹配前面字符0次或1次，即匹配ro或o,所以，roo应该分开看，前两个字符ro是匹配字符‘r’一次，o是匹配字符‘r’0次，同理oo也是分开看，都是匹配字符‘r’0次。
'r+o' +表示大于等于1个+号前面的字符
'r*o' *表示零个或多个*号前面的字符，
'r.*o' .* 任意一个字符+任意一个星号*前面的字符==任意零个或多个任意字符，r开头o结尾的字符，中间不重要，可以使特殊符号，贪婪匹配
'r*.o' 匹配出o前面有零个或者多个任意字符的行
-E 'r?o' -E 和 脱意符号\的作用一样，grep -E == egrep
过滤出带有某个关键字的行并输出行号
#grep -n 'root' 1.txt
过滤出不带某个关键词的行并输出行号
#grep -n -v 'root' 1.txt
过滤出所有包含数字的行
#grep '[0-9]' 1.txt 任意一个数字都可以匹配，多个也可以
过滤所有不包含数字的行
#grep -v '[0-9]' 1.txt
去除所有以"#"开头的行
#grep -v '^#' 1.txt
去除所有空行和以 # 开头的行
#grep -v '^$' 1.txt |grep -v '^#'
过滤英文字母开头的行
#grep '^[a-zA-Z]' 1.txt
过滤以非数字开头的行
#grep '^[^0-9]' 1.txt 匹配结果会首字母会颜色标出，匹配特殊符号
#grep -nv '^[0-9]' 1.txt 匹配结果差别在下面这个没有颜色，匹配特殊符号以及空行
过滤任意一个或多个字符 包含r.o，s*.d，p.*x的字符
#grep 'r.o' 1.txt ; grep 'r*t' 1.txt ; grep 'r.*t' 1.txt
. 表示任意一个字符
* 表示 零个 或 多个 前面的字符
.* 表示零个或多个任意字符，空行也包含在内
过滤出包含 root 的行以及下面一行
#grep -A 1 'root' 1.txt
过滤出包含root的行以及上面一行
#grep -B 1 ‘root' 1.txt
指定过滤字符次数 匹配一个oo的行
#grep 'o\{2\}' 1.txt
过滤包含2个字母o的行

3、egrep
grep工具的扩展，可以实现所有的grep功能，可以用grep -E代替egrep。为方便可全部使用egrep来代替grep。
#alias egrep='egrep --color'
#grep 'r\?o' 1.txt == egrep 'r\?o' 1.txt== grep -E 'r?o' 1.txt
匹配 1 个或 1 个以上 + 前面的字符 匹配o+
#egrep 'o+' 1.txt
匹配 0 个或 1 个 ? 前面字符 匹配o?
#egrep 'o?' 1.txt
匹配 roo 或者 匹配 body
#egrep 'roo|body' 1.txt
匹配包含roo 并且 包含 log 的行
#egrep 'roo' 1.txt |egrep 'roo|log'
#egrep 'log' 1.txt |egrep 'roo|log'
用括号表示一个整体，例子会匹配 roo 或者 ato
#egrep 'r(oo)|(at)o' 1.txt
匹配 1 个或者多个 'oo'
#egrep '(oo)+' 1.txt
匹配 1 到 3 次 'oo'
#egrep '(oo){1,3}' 1.txt
匹配结果出现9个o，{1,3}进行了多次匹配，也可以理解为包含但不限于1-3次。1.txt文件中某一行能匹配oo 1次、2次、3次都符合条件。对于 oooooooooo，前面6个o 符合：匹配oo3次；后面4个o符合匹配oo2次
#egrep '(oo){6}' 1.txt 匹配6个
#egrep '(oo)'{6,} 1.txt 匹配6个以上

4、. * + ? 总结 统配字符
. 任意字符，包括特殊字符，下划线，空格，
* 零个 或者 多个 *前面的字符
.* 任意数量任意字符，包括空行
*. 'r*.o' 匹配出o前面有零个或者多个任意字符的行
+ 表示 1 个或 多个 + 前面的字符 仅限egrep
？ 表示 0 个或 1 个？前面的字符 仅限egrep
grep 表达式里面出现 ？ + （ ） { } | 这几个特殊符号，需要前面加脱意符号，或者使用 grep -E ，或者使用egrep，故方便起见，全部使用egrep。
扩展 --include 指定文件
grep 其实还可以这样使用:
在tmp目录下，过滤所有 *.txt 文档中含有root的行
grep -r --include="*.txt" 'root' /

data目录下，所有 *.php 文档中包含eval的行
egrep -rhn --include="*.php" 'eval' 1.txt

sed 命令可以很好的进行行匹配，但从某一行中精确匹配某些内容，则使用 grep 命令并辅以 -o 和 -E 选项可达到此目的。其中 -o 表示“only-matching”，即“仅匹配”之意。光用它不够，配合 -E 选项使用扩展正则表达式则威力巨大。
比如下面有一条文本 tmp.txt ，其中内容为：
{"aid":45,"path":"attachment/Mon_1112/2_1_5728040df3ab346.jpg"}
我们想从中过略出 aid 的值即 45 ，那么可以先如下这么做：
grep -o -E 'aid":[1-9]*' tmp.txt

得到的结果为：
aid":45
这时就好办了，我们可以使用 awk 的 -F 选项指示出冒号分隔符，这样就容易过滤出 45 这个值来，整个命令综合如下：
grep -o -E 'aid":[1-9]*' tmp.txt |awk-F: '{print $2}'