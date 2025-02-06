import subprocess
import platform

class ServiceChecker:
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def get_service_status(self, service_name):
        os_type = platform.system()
        try:
            if os_type == 'Linux':
                result = subprocess.run(
                    ['systemctl', 'is-active', service_name],
                    stdout=subprocess.PIPE,
                    stderr=subprocess.PIPE,
                    text=True
                )
                return result.stdout.strip()
            elif os_type == 'Windows':
                result = subprocess.run(
                    ['powershell', '-Command', f"(Get-Service -Name '{service_name}').Status"],
                    stdout=subprocess.PIPE,
                    stderr=subprocess.PIPE,
                    text=True
                )
                return result.stdout.strip()
            else:
                return "Unsupported OS"
        except Exception as e:
            return f"Error: {str(e)}"
