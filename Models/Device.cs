using System;
using System.Collections.Generic;

namespace Server.Models;

public partial class Device
{
    public long DeviceId { get; set; }

    public string[]? IpAddress { get; set; }

    public string UserId { get; set; } = null!;

    public DateTime? LastLoginTime { get; set; }

    public virtual ICollection<ConnectionRequest> ConnectionRequests { get; } = new List<ConnectionRequest>();

    public virtual ICollection<DevicesTcu> DevicesTcus { get; } = new List<DevicesTcu>();

    public virtual ICollection<LockRequest> LockRequests { get; } = new List<LockRequest>();

    public virtual AspNetUser User { get; set; } = null!;
}
