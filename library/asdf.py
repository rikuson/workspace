#!/usr/bin/python

from ansible.module_utils.basic import AnsibleModule
import subprocess

def main():
    module = AnsibleModule(
        argument_spec=dict(
            name=dict(required=True, type='str'),
        ),
        supports_check_mode=True
    )

    name = module.params['name']

    try:
        output = subprocess.run(['asdf', 'plugin', 'list'], capture_output=True, text=True)
        if name not in output.stdout:
            result = subprocess.run(['asdf', 'plugin', 'add', name], capture_output=True, text=True)
            if result.returncode != 0:
                module.fail_json(msg=f'Failed to add plugin {name}: {result.stderr}')
        output = subprocess.run(['asdf', 'list', name], capture_output=True, text=True)
        if not output.stdout.strip():
            result = subprocess.run(['asdf', 'install', name, 'latest'], capture_output=True, text=True)
            if result.returncode != 0:
                module.fail_json(msg=f'Failed to install {name}: {result.stderr}')
            result = subprocess.run(['asdf', 'global', name, 'latest'], capture_output=True, text=True)
            if result.returncode != 0:
                module.fail_json(msg=f'Failed to set global version for {name}: {result.stderr}')
            module.exit_json(changed=True)
        else:
            module.exit_json(changed=False)
    except subprocess.CalledProcessError as e:
        module.fail_json(msg=f'Error executing asdf command: {e}')

if __name__ == '__main__':
    main()
