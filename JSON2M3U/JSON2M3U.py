import json

def convert_json_to_m3u(json_input_path, output_m3u_path):
    # Legge il file JSON (supporta sia percorso file che stringa JSON)
    try:
        with open(json_input_path, "r", encoding="utf-8") as f:
            data = json.load(f)
    except Exception:
        # Se viene passato direttamente come stringa
        data = json.loads(json_input_path)

    lines = ["#EXTM3U"]
    group_name = data.get("name", "Zappr Channels")

    for ch in data.get("channels", []):
        lcn = ch.get("lcn", "")
        name = ch.get("name", "")
        logo = ch.get("logo", "")
        url = ch.get("url", "")
        
        # 1. Canale Principale
        if url:
            attrs = []
            if lcn:
                attrs.append(f'tvg-chno="{lcn}"')
                attrs.append(f'channel-id="{lcn}"')
            attrs.append(f'group-title="{group_name}"')
            if name:
                attrs.append(f'tvg-name="{name}"')
            if logo:
                attrs.append(f'tvg-logo="{logo}"')
                
            attr_str = " ".join(attrs)
            lines.append(f"#EXTINF:-1 {attr_str},{name}")
            lines.append(url)
            
        # 2. Sotto-canali / HBBTV o Separatori di categoria
        for hb in ch.get("hbbtv", []):
            if "categorySeparator" in hb:
                # Inserisce un separatore leggibile nei player M3U
                lines.append(f"#---- {hb['categorySeparator']} ----")
                continue
                
            sub_lcn = hb.get("sublcn", "")
            sub_name = hb.get("name", name)
            sub_logo = hb.get("logo", logo)
            sub_url = hb.get("url", "")
            
            if sub_url:
                sub_attrs = []
                if lcn and sub_lcn:
                    sub_attrs.append(f'tvg-chno="{lcn}.{sub_lcn}"')
                    sub_attrs.append(f'channel-id="{lcn}.{sub_lcn}"')
                elif lcn:
                    sub_attrs.append(f'tvg-chno="{lcn}"')
                
                sub_attrs.append(f'group-title="{group_name} (HBBTV/Feeds)"')
                if sub_name:
                    sub_attrs.append(f'tvg-name="{sub_name}"')
                if sub_logo:
                    sub_attrs.append(f'tvg-logo="{sub_logo}"')
                
                sub_attr_str = " ".join(sub_attrs)
                lines.append(f"#EXTINF:-1 {sub_attr_str},{sub_name}")
                lines.append(sub_url)

    # Scrive il file M3U di output
    with open(output_m3u_path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))
    
    print(f"Playlist M3U generata con successo: {output_m3u_path}")

# Esempio d'uso:
if __name__ == "__main__":
    # Sostituisci 'playlist.json' con il percorso del tuo file JSON
    convert_json_to_m3u("national.json", "output_channels.m3u")
