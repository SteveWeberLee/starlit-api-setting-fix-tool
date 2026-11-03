1.先去 DeepSeek 平台点 Key 旁边的“复制”按钮，让剪贴板里是 Key。

2.双击 1_network_probe.vbs，看 Node.js 能否连上 api.deepseek.com。

3.双击 2_check_env.vbs，看当前进程和用户环境变量里的 Key 尾号。

4.双击 3_check_clipboard.vbs，确认剪贴板里是 sk- 开头的 Key，而不是命令文本。

5.双击 4_clean_key.vbs，清洗 Key，并把清洗后的 Key 放回剪贴板。

6.双击 5_test_key.vbs，直接用这个 Key 请求 /chat/completions。显示 SUCCESS 才继续。

7.双击 6_set_env_permanent.vbs，把有效 Key 永久写入用户环境变量。

8.新开一个 PowerShell 窗口，再启动 Starlit继续设置。

注意：第 4 步会覆盖剪贴板；如果中途复制了别的东西，第 5/6 步前重新复制 Key 并再跑一次第 4 步。


（以上内容由deepseek生成）
