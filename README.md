# Megalixir

## What?

Megalixir is an attempt to create an Elixir + Phoenix + LiveView structure with modularized CSS/JS. It is built with the aforementioned tools + Surface (which is built based on Phoenix Live Components).
Each component has its own `[componentName].component.ts` and `[componentName].component.scss` files aside from the `.ex` file.

## Why?
Because the way Phoenix with webpack currently handles css and js is having them all compiled into one big bundle. There are nothing scoped or even modularized, meaning that in most Elixir/Phoenix apps, you're probably loading way more than you should at any given page.

## How?

Basically there's 2 key things here. As you can see on the structure just below, inside `/lib/megalixir_web/` there is a `components` folder which houses all `Shared Components`.

The `live` folder is almost exactly the same, but it can also contain its own `components` folder, which we'll call `Featured Components`.



```
 /megalixir_umbrella
  /apps
   /megalixir_web
    /assets
     /scss
      /themes
       [themeName].scss
       themes.scss
       default.scss
      app.scss
      phoenix.scss
     /ts
      app.ts
      socket.ts
     webpack.config.js
    /lib
     /megalixir_web
      /components
       /[componentName]
        /themes
        [componentName].component.ex
        [componentName].component.ts
        [componentName].component.scss
      /live
       /[pageName]
        /components
        /themes
        [pageName].page.live.ex
        [pageName].page.ts
        [pageName].page.scss
```

## Components

#### Structure
Following a structure similar to most JS Frameworks (like Angular), here each component must have its own `.scss` and `.ts` files.

```
/components
 /[componentName]
  /themes
  [componentName].component.ex
  [componentName].component.ts
  [componentName].component.scss
```

It's not required for them to have the `.component.[ext]` name, but it's good for organization and context.

#### Elixir

Since Megalixir uses `Surface`, here's what a component looks like:

```elixir
# Button.component.ex

defmodule Button do
  use Surface.Component

  @doc "Inner Button Text"
  property text, :string

  def render(assigns) do
    ~H"""
    <button class="button-comp button is-primary" >
      {{ @text }}
    </button>
    """
  end
end
```

I won't explain exactly how `Surface` works, there's always its own GitHub page, but it's good to at least show how a component should be on a simple level.

One thing extremely important: I couldn't find a way to make a truly scoped CSS, so you need to be careful when writing class names. I personally recommend using `RSCSS` and adding a meaningful class name for your component. In this example I'm using `button-comp`, which I definitely won't use anywhere else, unless I plan to modify the component with composition inside another component or feature (using the Atomic Design pattern).

#### Typescript

Nothing much to say here, since in an Elixir app we really shouldn't be using javascript that much.
In any case, the `.ts` file is basically so `webpack` can detect the `.scss` file and compile it, but you could also put some typescript code here to do something you can't with Elixir alone (like google maps, for example).

```ts
// Button.component.ts

import './Button.component.scss';
```

#### Themes

Inside the `.scss` file we need to import `Themes/default`. `Themes/themes` is optional, since there are components which just don't need any theme at all aside from the default.

```scss
// Button.component.scss

@import 'Themes/themes';
@import 'Themes/default';

@import './themes/cargosense.theme';
@import './themes/dhl.theme';

.button-comp {
  border: none;
  background-color: $primaryButtonColor;

  @include themify($themes) {
    background-color: themed('primaryButtonColor');
  }
}
```

`Themes/default` lets us use the `SCSS Variables` defined in `/assets/scss/themes/default.scss`.
`Themes/themes` lets us use the `themify()` and `themed()` functions.

`themify()` generates a selector with `.theme-[themeName]` as a parent. The `[themeName]` is generated automatically based on the themes defined in `/assets/scss/themes/[themeName].scss`.

`themed()` is a helper function which lets you use the variables of the currently iterated theme.


```scss
// /assets/scss/themes/themes.scss

@import './cargosense.scss';
@import './dhl.scss';

$themes: map-merge($cargoSenseTheme, $dhlTheme);

@mixin themify($themes: $themes) {
  @each $theme, $map in $themes {

    .theme-#{$theme} & {
      $theme-map: () !global;
      @each $key, $submap in $map {
        $value: map-get(map-get($themes, $theme), '#{$key}');
        $theme-map: map-merge($theme-map, ($key: $value)) !global;
      }

      @content;
      $theme-map: null !global;
    }

  }
}

@function themed($key) {
  @return map-get($theme-map, $key);
}
```

```scss
// /assets/scss/themes/cargosense.scss

// Declare all variables
$cargoSenseTheme: (
  cargosense: (
    primaryButtonColor: #ab47bc
  )
)

// Declare all global layout changes (basically everything that's not a feature or a component)
```

In short, each theme will be a `Map` containing another `Map`, and then they're gonna all be merged into a single `Map` inside `/assets/scss/themes/themes.scss`

So the

```scss
// Button.component.scss

.button-comp {
  border: none;
  background-color: $primaryButtonColor;

  @include themify($themes) {
    background-color: themed('primaryButtonColor');
  }
}
```

becomes

```css
// Generated Button css

.button-comp {
  border: none;
  background-color: #00d1b2; }
  .theme-cargosense .button-comp {
    background-color: #ab47bc; }
  .theme-dhl .button-comp {
    background-color: #42a5f5; }
```


## Pages

#### Structure

Pages works almost exactly the same as a `Component`, except that instead of being called `.component.[ext]`, it must be called `.page.[ext]`.

Also, each page can have its own `/components` folder, which as aforementioned, we call `Featured Components`. There's really no difference from the `Shared Components`, it's more like a organizational thing.

```
/live
 /[pageName]
  /themes
  /components
  components-list.ts
  [pageName].page.live.ex
  [pageName].page.ts
  [pageName].page.scss
```

As you can see, there's also a `components-list.ts` file. This is so webpack can know what components (Shared or Featured) are being used by the page.

#### Elixir

```elixir
# example.page.live.ex

defmodule MegalixirWeb.Live.Example do
  use Surface.LiveView

  def render(assigns) do
    ~H"""
    <link rel="stylesheet" href="/css/example.page.css" />
    <script src="/js/example.page.js"> </script>

    <section class="example-page">
      <Button text="Generic Button" />
      <ExampleButton />
    </section>
    """
  end
end
```

There are 2 things to notice here:

 - Surface is built based on LiveComponents, so here we can use `Surface.LiveView` insted of `Phoenix.LiveView`.

 - We need to include both `<link>` and `<script>` tags inside the render. It's not optimal, but I couldn't find another way to make Elixir include them.


#### Typescript

Just like the `.component.ts`, there's really not much to say about it.
The only thing is that on the `.page.ts` file you will need to use the `App/` path to import both `.page.scss` and `components-list.ts`.

```ts
// /lib/megalixir_web/live/example/example.page.ts

import 'App/live/example/example.page.scss';
import 'App/live/example/components-list';

```

```ts
// /lib/megalixir_web/live/example/components-list.ts

/**
 * Import every used component js
 */


/**
 * Shared Components
 */

import '../../components/Button/Button.component';


/**
 * Local Components
 */

import './components/ExampleButton/ExampleButton.component';
```

#### Themes

Pages' themes works exactly the same as components' themes.

```scss
// /lib/megalixir_web/live/example/example.page.scss

@import 'Themes/themes';
@import 'Themes/default';

@import './themes/cargosense.theme';
@import './themes/dhl.theme';

.example-page > .button-comp {
  box-shadow: 0px 2px 5px rgba(0,0,0,0.4);
}
```

## Assets

#### Structure

```
/assets
 /scss
  /themes
   [themeName].scss
   default.scss
   themes.scss
  app.scss
  phoenix.scss
```

#### Sass

Not much to say about, the `app.scss` is where you should place global style changes (usually targeting the body, or the classic `*, *::before, *::after { box-sizing: border-box; }`).

It's also where you should import `phoenix.scss` and every Bulma file you'll want to use.

```scss
// /assets/scss/app.scss

/* This file is for your main application css. */

@import "./phoenix.scss";
@import "bulma/sass/utilities/_all.sass";
@import "bulma/sass/grid/columns.sass";
@import "bulma/sass/elements/button.sass";
```

The `themes/[themeName].scss`, as shown before, needs to have a variable which is a `Map` containing another `Map`, which contains the themes' variables.

If there's any global layout changes with this theme, it can also be placed here inside `.theme-cargosense { }`.

```scss
// /assets/scss/themes/cargosense.scss

// Declare all variables
$cargoSenseTheme: (
  cargosense: (
    primaryButtonColor: #ab47bc
  )
);

// Declare all global layout changes (basically everything that's not a feature or a component)

.theme-cargosense {

}
```

The `themes/default.scss` is where you should place all default variable colors, with the same names used on the `[themeName].scss` themes.

```scss
// /assets/scss/themes/default.scss

$primaryButtonColor: #00d1b2;
```

The `themes/themes.scss` contains the `$themes` variable which will merge all the themes declared on `/assets/scss/themes/[themeName].scss`, and both the `themify()` function and `themed()` function.

```scss
@import './cargosense.scss';
@import './dhl.scss';

$themes: map-merge($cargoSenseTheme, $dhlTheme);

@mixin themify($themes: $themes) {
  @each $theme, $map in $themes {

    .theme-#{$theme} & {
      $theme-map: () !global;
      @each $key, $submap in $map {
        $value: map-get(map-get($themes, $theme), '#{$key}');
        $theme-map: map-merge($theme-map, ($key: $value)) !global;
      }

      @content;
      $theme-map: null !global;
    }

  }
}

@function themed($key) {
  @return map-get($theme-map, $key);
}
```

#### Webpack

Not much to say here too, basically the `entry` constant makes webpack to search the entire project for the `.page.ts` files (which includes all `.component.ts` used by that page) and generate a new entry for each page found.

This way you won't ever need to include anything here on webpack, making things work automatically, as long as every new page is named as `[pageName].page.ts`.

```js
const entry = glob.sync('../lib/megalixir_web/**/*.page.ts').reduce((acc, curr) => {
  return Object.assign(acc, {[path.basename(curr).replace('.ts', '')]: curr})
}, {['app']: ['./ts/app.ts']});

module.exports = (env, options) => ({
  optimization: {
    minimizer: [
     ...
    ]
  },
  entry,
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, '../priv/static/js')
  },
  module: {
    ...
  }
  ...
});
```

## Installation and Startup

```bash
# Install Elixir deps
# /megalixir_umbrella/
$ mix deps.get

# Install NPM dependencies
# /megalixir_umbrella/apps/megalixir_web/assets/
$ npm i

# Run
# /megalixir_umbrella/
$ mix phx.server
```