using System;
using System.Collections.Generic;

namespace Server.Models;

public partial class Tcu
{
    public string[]? IpAddress { get; set; }

    public string[] Vin { get; set; } = null!;

    public long TcuId { get; set; }

    public long CurrentVersionId { get; set; }

    public string UserId { get; set; } = null!;

    public virtual ICollection<Alert> Alerts { get; } = new List<Alert>();

    public virtual ICollection<ConnectionRequest> ConnectionRequests { get; } = new List<ConnectionRequest>();

    public virtual SoftwareVersion CurrentVersion { get; set; } = null!;

    public virtual ICollection<DevicesTcu> DevicesTcus { get; } = new List<DevicesTcu>();

    public virtual ICollection<LockRequest> LockRequests { get; } = new List<LockRequest>();

    public virtual AspNetUser User { get; set; } = null!;
}
