# insta_clone

# tailwind setup

# create tailwind.config.js without node moduels

in powershell or teriminal :npx tailwindcss-cli@latest init
creat static golbally and inside that css/input.css
import @tailwind base; @tailwind components; @tailwind utilities; these three library form tailwind
and then run this command on teriminal or powershell to buid the tailwind css
npx @tailwindcss/cli -i ./static/css/input.css -o ./static/css/output.css --watch

-- watch is used to run tailwind continious
