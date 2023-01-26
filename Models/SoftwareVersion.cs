using System;
using System.Collections.Generic;

namespace Server.Models;

public partial class SoftwareVersion
{
    public long VersionId { get; set; }

    public string Rxwin { get; set; } = null!;

    public DateTime CreationTimeStamp { get; set; }

    public long? PreviousVersion { get; set; }

    public virtual SoftwareVersion? InverseVersion { get; set; }

    public virtual ICollection<Tcu> Tcus { get; } = new List<Tcu>();

    public virtual SoftwareVersion Version { get; set; } = null!;
}
