vilya-frontend
==============

A standalone web app for CODE (https://github.com/douban/code).

## Usage

Install dependencies:

    npm install
    bower install

Start static server at `localhost:9000`:

    grunt

Now you can access `localhost:9000` in your browser

The static server will proxy any access to path `/api/` to `localhost:8000/api`.
So start your CODE server and `8000` port. You can change `8000` to other port
in `Gruntfile.coffee`

## License
Licensed under BSD License, see [LICENSE](LICENSE)
