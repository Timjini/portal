const esbuild = require('esbuild');

const watchOptions = {
  onRebuild(error, result) {
    if (error) console.error('Build failed:', error);
    else console.log('Build succeeded:', result);
  },
};

const buildOptions = {
  entryPoints: ['./src/index.js'], // Adjust your entry points accordingly
  bundle: true,
  outfile: './dist/bundle.js', // Adjust your output file path accordingly
  watch: watchOptions,
  external: ['turbolinks'], 
};

esbuild.build(buildOptions).catch(() => process.exit(1));
