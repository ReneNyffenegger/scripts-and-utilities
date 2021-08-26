#
# Print IP addresses of local network interfaces.
# Inpsired by https://github.com/Treer/ip4
#
# V1
#
#
# Adapter is another word for network interface.
#
$adapters = [System.Net.NetworkInformation.NetworkInterface]::GetAllNetworkInterfaces()

foreach ($adapter in $adapters) {
   '{0,-30} {1,-20} {2}' -f $adapter.name, $adapter.networkInterfaceType, $adapter.operationalStatus

   foreach ($addressInfo in $adapter.GetIPProperties().UnicastAddresses) {

      $address = $addressInfo.Address

      if ( # Skip loopback addresses, non IP V4 (Internetwork) and non IP V6 (InternetworkV6)

        ( -not [System.Net.IPAddress]::IsLoopback($address)                                                 ) -and
        ( $adapter.NetworkInterfaceType -ne  [System.Net.NetworkInformation.NetworkInterfacetype]::Loopback ) -and
        ( $address.AddressFamily        -in ([System.Net.Sockets.AddressFamily]::Internetwork,
                                             [System.Net.Sockets.AddressFamily]::InternetworkV6)            )
      ) {

        "  $($address.IPAddressToString)"

      }
   }
}
