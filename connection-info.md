# Lab Materials Git 仓库连接信息

## 仓库地址

```
ssh://Administrator@192.168.1.114/D:/GitRepos/lab-materials.git
```

> **注意**：当前本机局域网 IP 为 `192.168.1.114`，如果 IP 变动，需要同步更新队友的仓库地址。

## 当前用户名

- **用户名**：`Administrator`
- **主机**：`192.168.1.114`
- **端口**：`22`（SSH 默认）

## 认证方式

1. **SSH 密钥认证**（推荐）
2. **密码认证**（需要 OpenSSH 服务器安装完成后可用）

## 队友添加 SSH 公钥的方法

当队友把他们的公钥发给你时，在台式机上执行：

```powershell
$teammateKey = "ssh-ed25519 AAAAC3NzaC... teammate@pc"
Add-Content -Path "$env:USERPROFILE\.ssh\authorized_keys" -Value $teammateKey -Encoding UTF8
```

把 `AAAAC3NzaC...` 替换为队友的实际公钥。

## 队友克隆仓库

```bash
git clone ssh://Administrator@192.168.1.114/D:/GitRepos/lab-materials.git
```

## 工作流程（Squash Merge）

```bash
# 1. 创建功能分支
git checkout -b feature/xxx

# 2. 在功能分支上开发...
# ...

# 3. 切回 main
git checkout main

# 4. Squash 合并功能分支
git merge --squash feature/xxx

# 5. 提交
git commit -m "feat: xxx"

# 6. 推送
git push origin main
```

> **重要**：直接 push 到 `main`/`master` 会被拒绝，必须使用 squash merge。

## 注意事项

1. **台式机需要保持开机**，队友才能 pull/push。
2. **校园网内访问**：确保台式机和队友的电脑在同一个局域网（192.168.1.x 网段）。
3. **IP 变动**：如果台式机 IP 变化，需要更新仓库地址。可以在路由器设置静态 IP 绑定。
4. **备份**：定期备份 `D:\GitRepos\lab-materials.git` 目录。
