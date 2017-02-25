# cygwin, bash, screen, vim他

## vim

### cygwin+screen上のvimでカーソル形状を変える方法

cygwinのターミナルは`xterm`のため、以下の制御シーケンスでカーソル形状を変更できる。

```bash
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
```

一方、cygwin+screen上ではターミナルが`screen`のため、上記の制御シーケンスはscreenに
キャッチされてしまうため、正常にターミナルに伝わらない。

そのため、screenのエスケープシーケンス(`\eP...\e\\`)で囲むことで正常にターミナルへ
制御シーケンスを伝える事ができる。

```bash
let &t_ti.="\eP\e[1 q\e\\"
let &t_SI.="\eP\e[5 q\e\\"
let &t_EI.="\eP\e[1 q\e\\"
let &t_te.="\eP\e[0 q\e\\"
```

#### カーソル形状制御シーケンス

* `ESC [ 0 SP q` ⇒ mintty のデフォルト設定
* `ESC [ 1 SP q` ⇒ ブロック型、点滅あり
* `ESC [ 2 SP q` ⇒ ブロック型、点滅なし
* `ESC [ 3 SP q` ⇒ 下線型、点滅あり
* `ESC [ 4 SP q` ⇒ 下線型、点滅なし
* `ESC [ 5 SP q` ⇒ ライン型、点滅あり
* `ESC [ 6 SP q` ⇒ ライン型、点滅なし

#### 参考URL

* [【vim】インサートモードでカーソルを目立たせる \| blog\.remora\.cx](http://blog.remora.cx/2012/10/spotlight-cursor-line.html)
* [PS1とPROMPT\_COMMAND, GNU screenでの活用も](https://rcmdnk.github.io/blog/2013/03/21/prompt-command/)

## cygwin

### cyg-fast導入

※導入してみたが、aria2でつまづきやすいので、今まで通り`apt-cyg`で良さげ。

下記依存パッケージがインストールされていないと正常に動かないので、事前に入れること。

* 依存パッケージ
    * wget
    * aria2
        * wgetと同じダウンロード支援ツール
    * tar
    * gawk

`cyg-fast`は以下からダウロードして適当な場所(`/usr/local/bin`)に配置すること

```bash
wget https://raw.githubusercontent.com/lambdalice/cyg-fast/master/cyg-fast -P /usr/local/bin
chmod +x /usr/local/bin/cyg-fast
cyg-fast -m ftp://ftp.iij.ad.jp/pub/cygwin/ update
```

### ターミナル色確認

以下のPerlスクリプトでターミナルで使用可能な文字の一覧を表示できる。

```perl
use strict;
use warnings;

my $fg = "\x1b[38;5;";
my $bg = "\x1b[48;5;";
my $rs = "\x1b[0m";

my $color = 0;

for(my $row = 0; $row < 32; ++$row) {
   for (my $col = 0; $col < 8; ++$col) {
      print get_color($color);
      $color++;
   }
   print "\n";
} 
sub get_color {
   my ($color) = @_;
   my $number = sprintf '%3d', $color;
   return qq/${bg}${color}m ${number} ${rs} ${fg}${color}m${number}${rs} /;
}
```

上記を`color256.pl`等のファイル名で保存し、実行する。

```bash
perl color256.pl
```

#### 参考URL

* [ターミナルで256色表示させる方法 \[ls,vim,tmux,などの設定に便利\] \- 大学生のプログラミングとかのあれこれ](http://kgeewimp.hatenablog.com/entry/2015/09/01/225653)

### X Window

cygwinにX Serverを導入する。

1. `setup-x86_64.exe`を実行して、以下をインストールする(最低限必要なパッケージ)。
    * xorg-server
    * xinit
    * openssh
2. 環境変数を設定する。

    ```bash:.bashrc
    if [ -n "{$DISPLAY}" ]; then
        export DISPLAY=localhost:0.0
    fi
    ```

3. `~/.ssh/config`の接続設定に`X11 Forward`を有効にする。

    ```bash:~/.ssh/config
    Host **
        HostName            ***
        Port                ***
        ForwardX11          yes
        ForwardX11Timeout   24h     # タイムアウトも設定しおくと良い。
    ```

4. `X Server`を起動する。

    ```bash
    run xwin -multiwindow -noclipboard -listen tcp
    ```

    ```bash:.bashrc
     # 以下のエイリアスをせって押しておくと楽
    alias runx='run xwin -multiwindow -noclipboard -listen tcp'
    ```

5. `ssh`に`-Y`オプションを付けて接続する。

    ```bash
    ssh -Y hostname
    ```

接続先の設定でX11 Forwardingが有効化されていない場合、sshdの設定を変更する。
`/ext/ssh/sshd_config`の`X11 Forwarding`を`yes`にして、sshdを再起動する。

```bash:/etc/ssh/sshd_config
X11Forwarding yes
 # service sshd restart
```

#### 参考URL

* [cygwin/x で Windows を X 端末として使う \- Qiita](http://qiita.com/mansonsp/items/1c52668b2f46002a754c)
* [3\.3 CygwinによるX Window利用 \[AFFRIT Portal\]](http://itcweb.cc.affrc.go.jp/affrit/documents/guide/x-window/x-win-cygwin)
* [Cygwinで X Windows を使う \- 計算物理屋の研究備忘録](http://keisanbutsuriya.hateblo.jp/entry/2015/01/25/221642)
