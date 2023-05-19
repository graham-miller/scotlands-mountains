cd "c:\Repos\scotlandsmountains.github.io"

call git rm -r *

xcopy "C:\Repos\scotlands-mountains\client\dist\client\*.*" "c:\Repos\scotlandsmountains.github.io" /s /e

call git add .

call git commit -m "Deployment"

call git push