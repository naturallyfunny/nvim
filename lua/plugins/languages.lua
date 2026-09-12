return {
  -- Java / Spring Boot (jdtls, java-debug-adapter, java-test)
  { import = "lazyvim.plugins.extras.lang.java" },

  -- Go
  { import = "lazyvim.plugins.extras.lang.go" },

  -- Python
  { import = "lazyvim.plugins.extras.lang.python" },

  -- Vue & Svelte (both require TypeScript)
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.vue" },
  { import = "lazyvim.plugins.extras.lang.svelte" },

  -- Web Development
  { import = "lazyvim.plugins.extras.lang.tailwind" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.linting.eslint" },

  -- .http scratch files to hit the API without leaving nvim (<leader>R)
  { import = "lazyvim.plugins.extras.util.rest" },
}
