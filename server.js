const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 3000;
const WEB_DIR = path.join(__dirname, 'build', 'web');

const mimeTypes = {
    '.html': 'text/html',
    '.js': 'application/javascript',
    '.css': 'text/css',
    '.json': 'application/json',
    '.png': 'image/png',
    '.jpg': 'image/jpeg',
    '.gif': 'image/gif',
    '.svg': 'image/svg+xml',
    '.ico': 'image/x-icon',
    '.woff': 'font/woff',
    '.woff2': 'font/woff2',
    '.ttf': 'font/ttf',
    '.otf': 'font/otf'
};

const server = http.createServer((req, res) => {
    // Remove query string and handle hash routes
    let url = req.url.split('?')[0].split('#')[0];
    
    // Default to index.html for root or any non-file path (SPA routing)
    let filePath = url === '/' ? '/index.html' : url;
    
    // If no extension, serve index.html (for SPA routing)
    if (!path.extname(filePath)) {
        filePath = '/index.html';
    }
    
    const fullPath = path.join(WEB_DIR, filePath);
    const extname = path.extname(fullPath).toLowerCase();
    const contentType = mimeTypes[extname] || 'application/octet-stream';

    fs.readFile(fullPath, (err, content) => {
        if (err) {
            if (err.code === 'ENOENT') {
                // File not found, try index.html for SPA
                fs.readFile(path.join(WEB_DIR, 'index.html'), (err2, indexContent) => {
                    if (err2) {
                        res.writeHead(404);
                        res.end('Not found');
                    } else {
                        res.writeHead(200, { 'Content-Type': 'text/html' });
                        res.end(indexContent);
                    }
                });
            } else {
                res.writeHead(500);
                res.end('Server error');
            }
        } else {
            res.writeHead(200, { 'Content-Type': contentType });
            res.end(content);
        }
    });
});

server.listen(PORT, () => {
    console.log(`Flutter Web Server running on http://localhost:${PORT}`);
    console.log(`Serving files from: ${WEB_DIR}`);
});
