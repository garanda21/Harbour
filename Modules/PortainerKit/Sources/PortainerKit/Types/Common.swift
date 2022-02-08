//
//  Common.swift
//  PortianerKit
//
//  Created by royal on 11/06/2021.
//

import Foundation

// MARK: - Generic enums

@available(iOS 15, macOS 12, *)
public extension PortainerKit {
	enum ContainerStatus: String, Decodable, Comparable {
		case created
		case running
		case paused
		case restarting
		case removing
		case exited
		case dead
		
		public static func < (lhs: PortainerKit.ContainerStatus, rhs: PortainerKit.ContainerStatus) -> Bool {
			let sorted: [Self] = [.created, .running, .paused, .restarting, .removing, .exited, .dead]
			let lhsIndex = sorted.firstIndex(of: lhs) ?? -1
			let rhsIndex = sorted.firstIndex(of: rhs) ?? -1
			return lhsIndex < rhsIndex
		}
	}
	
	enum EndpointStatus: Int, Decodable {
		case up = 1
		case down
	}
	
	enum EndpointType: Int, Decodable {
		case docker = 1
		case agent
		case azure
	}
	
	enum ExecuteAction: String {
		case start
		case stop
		case restart
		case kill
		case pause
		case unpause
		
		public var expectedState: ContainerStatus {
			switch self {
				case .start:	return .running
				case .stop:		return .exited
				case .restart:	return .restarting
				case .kill:		return .exited
				case .pause:	return .paused
				case .unpause:	return .running
			}
		}
	}
	
	enum MountConsistency: String, Decodable, Hashable {
		case `default`
		case consistent
		case cached
		case delegated
	}
	
	enum MountType: String, Decodable, Hashable {
		case bind
		case volume
		case tmpfs
	}
}

// MARK: - Generic types

@available(iOS 15, macOS 12, *)
public extension PortainerKit {
	struct AccessPolicy: Decodable {
		enum CodingKeys: String, CodingKey {
			case roleID = "RoleID"
		}
		
		public let roleID: Int?
	}
	
	struct AzureCredentials: Decodable {
		enum CodingKeys: String, CodingKey {
			case applicationID = "ApplicationID"
			case authenticationKey = "AuthenticationKey"
			case tenantID = "TenantID"
		}
		
		public let applicationID: String?
		public let authenticationKey: String?
		public let tenantID: String?
	}
	
	struct BindOptions: Decodable, Hashable {
		enum CodingKeys: String, CodingKey {
			case propagation = "Propagation"
		}
		
		public enum Propagation: String, Decodable {
			case `private`
			case rprivate
			case shared
			case rshared
			case slave
			case rslave
		}
		
		public let propagation: Propagation?
	}
	
	struct ContainerConfig: Decodable {
		enum CodingKeys: String, CodingKey {
			case hostname = "Hostname"
			case domainName = "DomainName"
			case user = "User"
			case attachStdin = "AttachStdin"
			case attachStdout = "AttachStdout"
			case attachStderr = "AttachStderr"
			case exposedPorts = "ExposedPorts"
			case tty = "Tty"
			case openStdin = "OpenStdin"
			case stdinOnce = "StdinOnce"
			case env = "Env"
			case cmd = "Cmd"
			case healthCheck = "HealthCheck"
			case argsEscaped = "ArgsEscaped"
			case image = "Image"
			case volumes = "Volumes"
			case workingDir = "WorkingDir"
			case entrypoint = "Entrypoint"
			case networkDisabled = "NetworkDisabled"
			case macAddress = "MacAddress"
			case onBuild = "OnBuild"
			case labels = "Labels"
			case stopSignal = "StopSignal"
			case stopTimeout = "StopTimeout"
			case shell = "Shell"
		}
		
		public let hostname: String
		public let domainName: String?
		public let user: String
		public let attachStdin: Bool
		public let attachStdout: Bool
		public let attachStderr: Bool
		public let exposedPorts: [String: [String: String]]?
		public let tty: Bool
		public let openStdin: Bool
		public let stdinOnce: Bool
		public let env: [String]
		public let cmd: [String]?
		public let healthCheck: HealthConfig?
		public let argsEscaped: Bool?
		public let image: String
		public let volumes: [String: [String: String]]?
		public let workingDir: String
		public let entrypoint: [String]?
		public let networkDisabled: Bool?
		public let macAddress: String?
		public let onBuild: [String]?
		public let labels: [String: String]
		public let stopSignal: String?
		public let stopTimeout: Int?
		public let shell: [String]?
	}
	
	struct ContainerState: Decodable {
		enum CodingKeys: String, CodingKey {
			case status = "Status"
			case running = "Running"
			case paused = "Paused"
			case restarting = "Restarting"
			case oomKilled = "OOMKilled"
			case dead = "Dead"
			case pid = "Pid"
			case error = "Error"
			case startedAt = "StartedAt"
			case finishedAt = "FinishedAt"
		}
		
		public let status: ContainerStatus
		public let running: Bool
		public let paused: Bool
		public let restarting: Bool
		public let oomKilled: Bool
		public let dead: Bool
		public let pid: Int
		public let error: String
		public let startedAt: Date?
		public let finishedAt: Date?
	}
	
	struct DockerSnapshot: Decodable {
		enum CodingKeys: String, CodingKey {
			case dockerVersion = "DockerVersion"
			case healthyContainerCount = "HealthyContainerCount"
			case imageCount = "ImageCount"
			case runningContainerCount = "RunningContainerCount"
			case serviceCount = "ServiceCount"
			case stackCount = "StackCount"
			case stoppedContainerCount = "StoppedContainerCount"
			case swarm = "Swarm"
			case time = "Time"
			case totalCPU = "TotalCPU"
			case totalMemory = "TotalMemory"
			case unhealthyContainerCount = "UnhealthyContainerCount"
			case volumeCount = "VolumeCount"
		}
		
		public let dockerVersion: String?
		public let healthyContainerCount: Int?
		public let imageCount: Int?
		public let runningContainerCount: Int?
		public let serviceCount: Int?
		public let stackCount: Int?
		public let stoppedContainerCount: Int?
		public let swarm: Bool?
		public let time: Int?
		public let totalCPU: Int?
		public let totalMemory: Int?
		public let unhealthyContainerCount: Int?
		public let volumeCount: Int?
	}
	
	struct DriverConfig: Decodable, Hashable {
		enum CodingKeys: String, CodingKey {
			case name = "Name"
			case options = "Options"
		}
		
		public let name: String?
		public let options: [String: String]?
	}
	
	struct EndpointExtension: Decodable {
		enum CodingKeys: String, CodingKey {
			case type = "Type"
			case url = "URL"
		}
		
		public let type: Int?
		public let url: String?
	}
	
	struct HealthConfig: Decodable {
		enum CodingKeys: String, CodingKey {
			case test = "Test"
			case interval = "Interval"
			case timeout = "Timeout"
			case retries = "Retries"
			case startPeriod = "StartPeriod"
		}
		
		public let test: [String]
		public let interval: Int
		public let timeout: Int
		public let retries: Int
		public let startPeriod: Int
	}
	
	struct GraphDriver: Decodable {
		public struct GraphDriverData: Decodable {
			enum CodingKeys: String, CodingKey {
				case lowerDir = "LowerDir"
				case mergedDir = "MergedDir"
				case upperDir = "UpperDir"
				case workDir = "WorkDir"
			}
			
			public let lowerDir: String
			public let mergedDir: String
			public let upperDir: String
			public let workDir: String
		}
		
		enum CodingKeys: String, CodingKey {
			case name = "Name"
			case data = "Data"
		}
		
		public let name: String
		public let data: GraphDriverData
	}
	
	struct HostConfig: Decodable {
		/*
		{
			"AutoRemove": false,
			"Binds": null,
			"BlkioDeviceReadBps": null,
			"BlkioDeviceReadIOps": null,
			"BlkioDeviceWriteBps": null,
			"BlkioDeviceWriteIOps": null,
			"BlkioWeight": 0,
			"BlkioWeightDevice": [],
			"CapAdd": null,
			"CapDrop": null,
			"Cgroup": "",
			"CgroupParent": "",
			"CgroupnsMode": "host",
			"ConsoleSize": [
				0,
				0
			],
			"ContainerIDFile": "",
			"CpuCount": 0,
			"CpuPercent": 0,
			"CpuPeriod": 0,
			"CpuQuota": 0,
			"CpuRealtimePeriod": 0,
			"CpuRealtimeRuntime": 0,
			"CpuShares": 0,
			"CpusetCpus": "",
			"CpusetMems": "",
			"DeviceCgroupRules": null,
			"DeviceRequests": null,
			"Devices": [],
			"Dns": [],
			"DnsOptions": [],
			"DnsSearch": [],
			"ExtraHosts": null,
			"GroupAdd": null,
			"IOMaximumBandwidth": 0,
			"IOMaximumIOps": 0,
			"IpcMode": "private",
			"Isolation": "",
			"KernelMemory": 0,
			"KernelMemoryTCP": 0,
			"Links": null,
			"LogConfig": {
				"Config": {},
				"Type": "json-file"
			},
			"MaskedPaths": [
				"/proc/asound",
				"/proc/acpi",
				"/proc/kcore",
				"/proc/keys",
				"/proc/latency_stats",
				"/proc/timer_list",
				"/proc/timer_stats",
				"/proc/sched_debug",
				"/proc/scsi",
				"/sys/firmware"
			],
			"Memory": 0,
			"MemoryReservation": 0,
			"MemorySwap": 0,
			"MemorySwappiness": null,
			"NanoCpus": 0,
			"NetworkMode": "default",
			"OomKillDisable": null,
			"OomScoreAdj": 0,
			"PidMode": "",
			"PidsLimit": null,
			"PortBindings": {},
			"Privileged": false,
			"PublishAllPorts": false,
			"ReadonlyPaths": [
				"/proc/bus",
				"/proc/fs",
				"/proc/irq",
				"/proc/sys",
				"/proc/sysrq-trigger"
			],
			"ReadonlyRootfs": false,
			"RestartPolicy": {
				"MaximumRetryCount": 0,
				"Name": "no"
			},
			"Runtime": "runc",
			"SecurityOpt": null,
			"ShmSize": 67108864,
			"UTSMode": "",
			"Ulimits": null,
			"UsernsMode": "",
			"VolumeDriver": "",
			"VolumesFrom": null
		}
		 */
	}
	
	struct IPAMConfig: Decodable {
		enum CodingKeys: String, CodingKey {
			case ipv4Address = "IPv4Address"
			case ipv6Address = "IPv6Address"
			case linkLocalIPs = "LinkLocalIPs"
		}
		
		public let ipv4Address: String?
		public let ipv6Address: String?
		public let linkLocalIPs: [String]?
	}
	
	struct KubernetesConfiguration: Decodable {
		enum CodingKeys: String, CodingKey {
			case ingressClasses = "IngressClasses"
			case storageClasses = "StorageClasses"
			case useLoadBalancer = "UseLoadBalancer"
			case useServerMetrics = "UseServerMetrics"
		}
		
		public let ingressClasses: [KubernetesIngressClassConfig]?
		public let storageClasses: [KubernetesStorageClassConfig]?
		public let useLoadBalancer: Bool?
		public let useServerMetrics: Bool?
	}
	
	struct KubernetesData: Decodable {
		enum CodingKeys: String, CodingKey {
			case configuration = "Configuration"
			case snapshots = "Snapshots"
		}
		
		public let configuration: KubernetesConfiguration?
		public let snapshots: [KubernetesSnapshot]?
	}
	
	struct KubernetesIngressClassConfig: Decodable {
		enum CodingKeys: String, CodingKey {
			case name = "Name"
			case type = "Type"
		}
		
		public let name: String
		public let type: String
	}
	
	struct KubernetesSnapshot: Decodable {
		enum CodingKeys: String, CodingKey {
			case kubernetesVersion = "KubernetesVersion"
			case nodeCount = "NodeCount"
			case time = "Time"
			case totalCPU = "TotalCPU"
			case totalMemory = "TotalMemory"
		}
		
		public let kubernetesVersion: String?
		public let nodeCount: Int?
		public let time: Int?
		public let totalCPU: Int?
		public let totalMemory: Int?
	}
	
	struct KubernetesStorageClassConfig: Decodable {
		enum CodingKeys: String, CodingKey {
			case accessModes = "AccessModes"
			case allowVolumeExpansion = "AllowVolumeExpansion"
			case name = "Name"
			case provisioner = "Provisioner"
		}
		
		public let accessModes: [String]?
		public let allowVolumeExpansion: Bool?
		public let name: String?
		public let provisioner: String?
	}

	struct Motd: Decodable {
		enum CodingKeys: String, CodingKey {
			case title = "Title"
			case message = "Message"
			case style = "Style"
			case hash = "Hash"
		}

		let title: String
		let message: String
		let style: String
		let hash: String?
	}
	
	struct Mount: Decodable, Hashable {
		enum CodingKeys: String, CodingKey {
			case target = "Target"
			case source = "Source"
			case type = "Type"
			case readOnly = "ReadOnly"
			case consistency = "Consistency"
			case bindOptions = "BindOptions"
			case volumeOptions = "VolumeOptions"
			case tmpfsOptions = "TmpfsOptions"
		}
		
		public let target: String?
		public let source: String?
		public let type: MountType?
		public let readOnly: Bool?
		public let consistency: MountConsistency?
		public let bindOptions: BindOptions?
		public let volumeOptions: VolumeOptions?
		public let tmpfsOptions: TmpfsOptions?
		
		public static func == (lhs: PortainerKit.Mount, rhs: PortainerKit.Mount) -> Bool {
			lhs.target == rhs.target && lhs.source == rhs.source && lhs.type == rhs.type && lhs.readOnly == rhs.readOnly
		}
	}
	
	struct MountPoint: Decodable, Hashable {
		enum CodingKeys: String, CodingKey {
			case type = "Type"
			case name = "Name"
			case source = "Source"
			case destination = "Destination"
			case driver = "Driver"
			case mode = "Mode"
			case rw = "RW"
			case propagation = "Propagation"
		}
		
		public let type: String
		public let name: String?
		public let source: String
		public let destination: String
		public let driver: String?
		public let mode: String
		public let rw: Bool
		public let propagation: String
	}
	
	struct Network: Decodable {
		enum CodingKeys: String, CodingKey {
			case ipamConfig = "IPAMConfig"
			case links = "Links"
			case aliases = "Aliases"
			case networkID = "NetworkID"
			case endpointID = "EndpointID"
			case gateway = "Gateway"
			case ipAddress = "IPAddress"
			case ipPrefixLen = "IPPrefixLen"
			case ipv6Gateway = "IPv6Gateway"
			case globalIPv6Address = "GlobalIPv6Address"
			case globalIPv6PrefixLen = "GlobalIPv6PrefixLen"
			case macAddress = "MacAddress"
		}
		
		public let ipamConfig: IPAMConfig?
		public let links: [String]?
		public let aliases: [String]?
		public let networkID: String?
		public let endpointID: String?
		public let gateway: String?
		public let ipAddress: String?
		public let ipPrefixLen: Int?
		public let ipv6Gateway: String?
		public let globalIPv6Address: String?
		public let globalIPv6PrefixLen: Int64?
		public let macAddress: String?
	}

	struct Port: Decodable, Hashable {
		enum CodingKeys: String, CodingKey {
			case ip = "IP"
			case privatePort = "PrivatePort"
			case publicPort = "PublicPort"
			case type = "Type"
		}
		
		public enum PortType: String, Decodable {
			case tcp
			case udp
		}
		
		public let ip: String?
		public let privatePort: UInt16?
		public let publicPort: UInt16?
		public let type: PortType?
	}
	
	struct TmpfsOptions: Decodable, Hashable {
		enum CodingKeys: String, CodingKey {
			case sizeBytes = "SizeBytes"
			case mode = "Mode"
		}
		
		public let sizeBytes: Int64?
		public let mode: Int?
	}
	
	struct TLSConfiguration: Decodable {
		enum CodingKeys: String, CodingKey {
			case tls = "TLS"
			case tlsCACert = "TLSCACert"
			case tlsCert = "TLSCert"
			case tlsKey = "TLSKey"
			case tlsSkipVerify = "TLSSkipVerify"
		}
		
		public let tls: Bool?
		public let tlsCACert: String?
		public let tlsCert: String?
		public let tlsKey: String?
		public let tlsSkipVerify: Bool?
	}
	
	struct VolumeOptions: Decodable, Hashable {
		enum CodingKeys: String, CodingKey {
			case noCopy = "NoCopy"
			case labels = "Labels"
			case driverConfig = "DriverConfig"
		}
		
		public let noCopy: Bool?
		public let labels: [String: String]?
		public let driverConfig: DriverConfig?
	}
}