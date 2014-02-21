git-digest-brunch
=================

A [Brunch][http://brunch.io] plugin for cache busting urls using the SHA digest of the current git revision. 


## Usage

Install via npm:

    npm install --save git-digest-brunch

Add the `DIGEST` token to any file paths you want to cache bust:

    <link rel="stylesheet" href="stylesheets/app.css?DIGEST">
    background-image: url('/images/hello.png?DIGEST');
    canvas.image "/images/sprite.png?DIGEST", 0, 0, 150, 150
    etc.

Build via `brunch build` / `brunch watch`, file paths are now cache busted:

    <link rel="stylesheet" href="stylesheets/app.css?aca2b34">
    background-image: url('/images/hello.png?aca2b34');
    canvas.image "/images/sprite.png?aca2b34", 0, 0, 150, 150
    etc.


## License

The MIT License (MIT)

Copyright (c) 2014 William Meleyal (http://meleyal.com)
