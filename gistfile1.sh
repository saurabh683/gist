mkdir heroku
cd heroku/
virtualenv --no-site-packages env
source env/bin/activate
pip install bottle gevent

cat >app.py <<EOF
import bottle
import os

@bottle.route('/')
def index():
    return "Hello World"

bottle.run(server='gevent', port=os.environ.get('PORT', 5000))
EOF

echo 'web: app.py' > Procfile
echo 'env/' > .gitignore

git init
git add .
git commit -m "Initial commit"

heroku create
git push heroku master