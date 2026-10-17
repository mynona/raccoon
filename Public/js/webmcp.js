(function() {
  if (typeof document !== 'undefined' && 'modelContext' in document) {
    document.modelContext.registerTool({
      name: 'search_articles',
      description: 'Searches published articles, guides, and tools on raumnebenan.de.',
      inputSchema: {
        type: 'object',
        properties: {
          query: {
            type: 'string',
            description: 'The search query or keyword (e.g., "product discovery", "design thinking")'
          }
        },
        required: ['query']
      },
      annotations: {
        readOnlyHint: true,
        untrustedContentHint: false,
        consequentialHint: false
      },
      execute: async ({ query }) => {
        try {
          const response = await fetch('/mcp', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json'
            },
            body: JSON.stringify({
              jsonrpc: '2.0',
              id: Date.now(),
              method: 'tools/call',
              params: {
                name: 'search_articles',
                arguments: { query }
              }
            })
          });

          const data = await response.json();
          if (data.error) throw new Error(data.error.message || 'MCP error');

          return data.result?.content?.[0]?.text || JSON.stringify(data.result);
        } catch (err) {
          return `Error searching articles: ${err.message}`;
        }
      }
    });
  }
})();
