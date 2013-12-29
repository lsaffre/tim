from atelier.fablib import *
setup_from_project()

# demo site has no English, but userdocs are still based in English
# so we must manually specify the language settings:
env.userdocs_base_language = 'en'
env.languages = ['de']

# env.tolerate_sphinx_warnings = True
# env.use_mercurial = False
