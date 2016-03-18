<?php

$json = json_decode($_POST['survey_data']);

?><!DOCTYPE HTML>
<html>
<head>
    <title>Example HTTP POST handler</title>
</head>
<body>

Received data:
Timestamp (ISO 8601): <?php echo $json->datetime_iso8601; ?><br>
Venue name:         <?php echo $_POST["Venue.name"]; ?><br>
Owner:              <?php echo $_POST["Owner"]; ?><br>
Address:            <?php echo $_POST["Address"]; ?><br>
Geo coordinates:    <?php echo $json->geo->coords->latitude; ?>,<?php echo $json->geo->coords->longitude; ?><br>
SSID:               <?php echo $json->network->ssid; ?><br>
WAN IPv4 addresss:  <?php echo $json->network->wan_ip4;?><br>
IP range:           <?php echo $_POST["IP.range"]; ?><br>
DHCP pool:          <?php echo $_POST["DHCP.pool"]; ?><br>
VLAN configuration: <?php echo $_POST["VLAN.configuration"]; ?><br>
Gateway IPv4 address: <?php echo $json->network->gateway_ip4; ?><br>
Gateway IPv6 address: <?php echo $json->network->gateway_ip6; ?><br>
MAC address:        <?php echo $json->network->gateway_mac; ?><br>
vendor name:        <?php echo $_POST["vendor.name"]; ?><br>
Device family:      <?php echo $_POST["Device.family"]; ?><br>
Serial number:      <?php echo $_POST["Serial.number"]; ?>

</body>
</html>
