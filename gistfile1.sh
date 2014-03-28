mkdir heroku
cd heroku/
virtualenv --no-site-packages env
source env/bin/activate
pip install bottle gevent
pip freeze > requirements.txt

cat >app.py <<EOF
try:
    import gevent.monkey
    gevent.monkey.patch_all()
except:
    pass

import bottle
import os

@bottle.route('/')
def index():
    return "Hello World"

bottle.run(server='gevent', host='0.0.0.0', port=os.environ.get('PORT', 5000))
EOF

chmod a+x app.py

echo 'web: app.py' > Procfile
echo 'env/' > .gitignore

git init
git add .
git commit -m "Initial commit"

heroku create
git push heroku master