/**
 * 其实两组DNS就够了，一组国内，一组国外
 * defaultDNS是用来解析DNS的，必须为IP
 * DNS最好不要超过两个，从业界某知名APP的文档里学的
 */
const defaultDNS = ["tls://223.5.5.5"];

const chinaDNS = ["119.29.29.29", "223.5.5.5"];

const foreignDNS = ["tls://8.8.8.8", "tls://1.1.1.1", "tls://9.9.9.9"];

/**
 * DNS相关配置
 */
const dnsConfig = {
    enable: true,
    listen: ":1053",
    ipv6: true,
    "prefer-h3": true,
    "use-hosts": true,
    "use-system-hosts": true,
    "respect-rules": true,
    "enhanced-mode": "fake-ip",
    "fake-ip-range": "198.18.0.1/16",
    "fake-ip-filter": ["*", "+.lan", "+.local", "+.market.xiaomi.com"],
    "default-nameserver": [...defaultDNS],
    nameserver: [...foreignDNS],
    "proxy-server-nameserver": [...foreignDNS],
    /**
     * 这里对域名解析进行分流
     * 由于默认dns是国外的了，只需要把国内ip和域名分流到国内dns
     */
    "nameserver-policy": {
        "geosite:private": "system",
        "geosite:cn,steam@cn,category-games@cn,microsoft@cn,apple@cn": chinaDNS,
    },
};

const prependRules = [
    "DOMAIN-SUFFIX,hf-mirror.com,DIRECT", // hf-mirror
    "DOMAIN-SUFFIX,r2.cloudflarestorage.com,DIRECT", // ollama 模型下载
    "DOMAIN-SUFFIX,steamcontent.com,DIRECT", // steam 下载
    "DOMAIN-SUFFIX,mozilla.com,DIRECT", // mozilla
    "DOMAIN-SUFFIX,firefox.com,DIRECT",
    "DOMAIN-SUFFIX,massgrave.dev,DIRECT",
    "DOMAIN-SUFFIX,gravesoft.dev,DIRECT",
    "DOMAIN-SUFFIX,login.live.com,DIRECT",
    "PROCESS-NAME,SunloginClient,DIRECT",
    "PROCESS-NAME,SunloginClient.exe,DIRECT",
];

function main(config) {
    // 合并规则
    let oldRules = config.rules;
    config.rules = prependRules.concat(oldRules);

    // 允许局域网访问
    config["allow-lan"] = true;


    // 覆盖原配置中DNS配置
    // config["dns"] = dnsConfig;

    config["profile"] = {
        "store-selected": true,
        "store-fake-ip": true,
    };

    config["unified-delay"] = true;
    config["tcp-concurrent"] = true;

    /**
     * 适合小内存环境，如果在旁路由里运行可以改成standard
     */
    config["geodata-loader"] = "memconservative";

    config["geo-auto-update"] = true;

    config["geo-update-interval"] = 24;

    /**
     * 不开域名嗅探的话，日志里只会记录请求的ip，对查找问题不方便
     * override-destination默认值是true，但是个人建议全局设为false，否则某些应用会出现莫名其妙的问题
     * Mijia Cloud跳过是网上抄的
     */
    config["sniffer"] = {
        enable: true,
        "force-dns-mapping": true,
        "parse-pure-ip": true,
        "override-destination": false,
        sniff: {
            TLS: {
                ports: [443, 8443],
            },
            HTTP: {
                ports: [80, "8080-8880"],
            },
            QUIC: {
                ports: [443, 8443],
            },
        },
        "force-domain": [],
        "skip-domain": ["Mijia Cloud", "+.oray.com"],
    };

    config["geox-url"] = {
        geoip:
            "https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/geoip-lite.dat",
        geosite:
            "https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/geosite.dat",
        mmdb: "https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/country-lite.mmdb",
        asn: "https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/GeoLite2-ASN.mmdb",
    };

    return config;
}
