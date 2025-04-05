Invoke-WebRequest https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-windows-amd64.zip -OutFile ngrok.zip
Expand-Archive ngrok.zip
.\ngrok\ngrok.exe authtoken 2hlr5hFpZid0dajdFUQvzl6AvL1_4oeHWSyQ78RPdZHRMAY5d
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
Start-Process -NoNewWindow -FilePath .\ngrok\ngrok.exe -ArgumentList "tcp 3389 --log=stdout"
Start-Sleep -Seconds 5
$response = Invoke-RestMethod http://127.0.0.1:4040/api/tunnels
$tunnel = $response.tunnels | Where-Object {$_.proto -eq "tcp"}
Write-Output "Ngrok TCP RDP URL: $($tunnel.public_url)"
