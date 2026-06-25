import os
import sys
import platform
import time
from flask import Flask, render_template, jsonify, request

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/info')
def get_info():
    # Filter sensitive environment variables
    safe_env = {}
    for k, v in os.environ.items():
        k_upper = k.upper()
        if any(term in k_upper for term in ['PASS', 'SECRET', 'KEY', 'TOKEN', 'AUTH', 'CRED']):
            safe_env[k] = '********'
        else:
            safe_env[k] = v

    return jsonify({
        'status': 'Healthy',
        'os': platform.system(),
        'os_release': platform.release(),
        'python_version': sys.version.split(' ')[0],
        'container_time': time.strftime('%Y-%m-%d %H:%M:%S %Z'),
        'environment_vars': safe_env,
        'cpu_architecture': platform.machine(),
        'process_id': os.getpid()
    })

@app.route('/api/docker-helper', methods=['POST'])
def docker_helper():
    data = request.json or {}
    action = data.get('action', 'build')
    port = data.get('port', '8080')
    image_name = data.get('image_name', 'my-flask-app')
    
    commands = {
        'build': f'docker build -t {image_name} .',
        'run': f'docker run -d -p {port}:80 {image_name}',
        'stop': f'docker stop <container_id>',
        'logs': f'docker logs -f <container_id>',
        'exec': f'docker exec -it <container_id> sh',
    }
    
    return jsonify({
        'success': True,
        'command': commands.get(action, 'Invalid action'),
        'description': f'Docker command generated for action: {action}'
    })

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 80))
    app.run(host='0.0.0.0', port=port)
