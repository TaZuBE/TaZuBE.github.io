# 安装依赖
npm install

# 构建生产环境代码
npm run build

# 进入构建输出目录
cd dist

# 初始化 Git 仓库并提交代码
git init
git add -A
git commit -m "Deploy to GitHub Pages"

# 将代码推送到 GitHub Pages 分支
git push -f git@github.com:TaZuBE/TaZuBE.github.io.git main:gh-pages