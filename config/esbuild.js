const esbuild = require("esbuild")

esbuild.build({
    entryPoints: ["app/javascript/application.js"],
    bundle: true,
    sourcemap: true,
    outfile: "app/assets/builds",
    publicPath: 'assets',
    watch: true,
}).catch((e) => console.error(e.message));
