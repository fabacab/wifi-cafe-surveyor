<!DOCTYPE HTML>
<html>
<body>

Review the data you submitted:
timestamp (UTC):    <?php echo $_POST["time.UTC"]; ?><br>
Venue name:         <?php echo $_POST["Venue.name"]; ?><br>
Owner:              <?php echo $_POST["Owner"]; ?><br>
Address:            <?php echo $_POST["Address"]; ?><br>
Geo coordinates:    <?php echo $_POST["geo.coordinates"]; ?><br>
SSID:               <?php echo $_POST["SSID"]; ?><br>
IP range:           <?php echo $_POST["IP.range"]; ?><br>
DHCP pool:          <?php echo $_POST["DHCP.pool"]; ?><br>
VLAN configuration: <?php echo $_POST["VLAN.configuration"]; ?><br>
MAC address:        <?php echo $_POST["MAC.address"]; ?><br>
IP address:         <?php echo $_POST["IP.address"]; ?><br>
vendor name:        <?php echo $_POST["vendor.name"]; ?><br>
Device family:      <?php echo $_POST["Device.family"]; ?><br>
Serial number:      <?php echo $_POST["Serial.number"]; ?>

</body>
</html>
