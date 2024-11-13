rule = {
  matches = {
    {
      { "device.serial", "equals", "Sony_Interactive_Entertainment_Wireless_Controller" },
    },
  },
  apply_properties = {
    ["device.disabled"] = true,
  },
}

table.insert(alsa_monitor.rules, rule)
