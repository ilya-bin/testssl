# PowerShell analog of openssl command openssl s_client -connect myhost.com:443

$server = 'myhost.com'
$port = 443

# Create a TcpClient to connect to the server
$tcpClient = New-Object System.Net.Sockets.TcpClient($server, $port)

# Create an SslStream for secure communication
$sslStream = New-Object System.Net.Security.SslStream($tcpClient.GetStream(), $false)

# Try to authenticate and display the SSL certificate information
try {
    $sslStream.AuthenticateAsClient($server)
    $sslStream.RemoteCertificate | Format-List
} catch {
    Write-Host "SSL connection failed: $_"
} finally {
    # Close the connection
    $sslStream.Close()
    $tcpClient.Close()
}
