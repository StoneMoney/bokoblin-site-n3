module.exports = {
    apps: [
        {
            name: 'Bokoblin N3',
            port: '3333',
            exec_mode: 'cluster',
            instances: 'max',
            script: './.output/server/index.mjs',
            env_production: {
                DATABASE_URL: process.env.DATABASE_URL
            }
        }
    ]
}
  