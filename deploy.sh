#!/usr/bin/env sh
echo 复制deploy_plugin下的所有目录到dist/js
cp -r deploy_plugin/* dist/js/

echo 压缩部署包！
tar -zcvf dist.tar.gz dist/css/ dist/js/ dist/img/ dist/index.html

echo 上传文件
scp -r dist.tar.gz user@remote:/www/admin

# 服务器环境开启
ssh user@remote -tt <<EOF

echo 进入目标目录
cd www/admin

echo 删除css/ js/ img/ index.html
rm -rf css/ js/ img/ index.html

echo 解压dist.tar.gz
tar -zxvf dist.tar.gz --strip-components 1

echo 删除本地压缩包！
rm -rf dist.tar.gz

exit
EOF

# 服务器环境结束
echo 上传完成！

echo 删除本地压缩包！
rm -rf dist.tar.gz
