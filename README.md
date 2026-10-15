# git

本地实验仓库，关联到 GitHub 上 `Ilovegood123isgad/git`。

## 仓库地址

| 协议 | URL | 状态 |
| --- | --- | --- |
| HTTPS（当前使用） | `https://github.com/Ilovegood123isgad/git.git` | 已通 |
| SSH（备用） | `git@github.com:Ilovegood123isgad/git.git` | 待 GitHub auth 后端同步 key 后可用 |

## 当前可用通道：HTTPS

这台机器的 Windows 凭据管理器里已经缓存了 GitHub 的凭据（PAT），`git push` / `git pull` 走 HTTPS 直接走，不用每次输 token。

正常使用流程：

```powershell
cd E:\git
git status
git add .
git commit -m "你的提交说明"
git push
```

## 备用通道：SSH

`~/.ssh/` 目录里已经放好了一对 ed25519 key，fingerprint：

```
SHA256:nDzmfi0gq/2teY/1xX1EDC/Rvn40YxUIopWv14RHFmg  (ed25519)
```

公钥已加在 https://github.com/settings/keys，标题 `hp-laptop-retry`。**首次添加后 GitHub auth 后端要时间同步**，等同步好（UI 上 key 那行会从 `Never used` 变成具体时间）就可以切换到 SSH。

### 切换到 SSH

```powershell
cd E:\git
git remote set-url origin git@github.com:Ilovegood123isgad/git.git
git push
```

### 自检 SSH 是否已通

```powershell
powershell -ExecutionPolicy Bypass -File E:\git\test-ssh.ps1
```

脚本会显示本地 key 指纹、跑一次 `ssh -T git@github.com`，并根据结果提示下一步动作。

## 配置备忘

- **Git 身份（全局）**
  - `user.name`  = `Ilovegood123isgad`
  - `user.email` = `896877648@qq.com`
- **Git 身份（本仓库）** = 同全局
- **默认分支** = `main`
- **Git SSH 客户端** = `C:\Windows\System32\OpenSSH\ssh.exe`（通过 `core.sshCommand` 指定，避开 Git for Windows 自带 SSH 的 home 路径解析问题）
- **SSH 走 443**：`~/.ssh/config` 里把 `github.com` 映射到 `ssh.github.com:443`，绕开运营商对 22 端口的干扰

## 新建项目流程

```powershell
cd D:\path\to\new-project
git init -b main
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/Ilovegood123isgad/<repo-name>.git
git push -u origin main
```

> GitHub 上的远端仓库需要先去 https://github.com/new 创建好（可以是空仓库，不要勾选 Initialize with README），然后用上面命令 push 第一次提交。
