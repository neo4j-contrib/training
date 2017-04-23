define([], function(){
    return CypherHighlighter = function () {
        var endMarker = "",
            z = /(\/\*|\*\/|\/\/|\\"|"|\\'|'|\\`|`|\{[0-9A-Za-z_]+\}|<?--+>?|<?-+\[|\]-+>?|\\\\|\r|\n)/gm,
            no = /^(0\.[0-9]+|0|-?[1-9][0-9]*\.[0-9]+|-?[1-9][0-9]*)$/gi,
            co = /^(true|false|null)$/gi,
            kw = /^(and|as|asc|create unique|create|delete|desc|distinct|in|is|is not|limit|match|or|order by|relate|return|set|skip|start|unique|where|with|={3,})$/i,
            fn = /^(abs|any|all|avg|coalesce|collect|count|extract|filter|foreach|has|head|id|last|left|length|lower|ltrim|max|min|node|nodes|none|not|percentile_cont|percentile_disc|range|reduce|rel|relationship|relationships|replace|right|round|rtrim|shortestPath|sign|single|sqrt|str|substring|sum|tail|trim|type|upper)$/i;
        this.highlight = function(code) {
            var out = [];
            if (endMarker != "")
                out.push('<span class="string">');
            code = code.split(z);
            while (code.length > 0) {
                var c = code.shift();
                if (endMarker != "") {
                    out.push(c);
                    if (c == endMarker) {
                        out.push('</span>');
                        endMarker = "";
                    }
                } else if (c == "//") {
                    out.push('<span class="comment">');
                    out.push(c);
                    while (code.length > 0 && code[0] != "\r" && code[0] != "\n")
                        out.push(code.shift());
                    out.push(code.shift());
                    out.push('</span>');
                } else if (c == "'" | c == '"') {
                    out.push('<span class="string">');
                    out.push(c);
                    endMarker = c;
                } else if (c == "--" | c[0] == "<" | c[c.length - 1] == ">" | c[0] == "]" | c[c.length - 1] == "[") {
                    out.push('<span class="pattern">');
                    out.push(c);
                    out.push('</span>');
                } else if (c == "`") {
                    out.push('<span class="escaped">');
                    out.push(c);
                    endMarker = c;
                } else if (c[0] == "{") {
                    out.push('<span class="parameter">');
                    out.push(c);
                    out.push('</span>');
                } else {
                    c = c.split(/(create unique|is not|order by|[A-Z_][0-9A-Z_]*|={3,}|0\.[0-9]+|0|-?[1-9][0-9]*\.[0-9]+|-?[1-9][0-9]*)/gi);
                    while (c.length > 0) {
                        var d = c.shift();
                        if (no.test(d)) {
                            out.push('<span class="number">');
                            out.push(d);
                            out.push('</span>');
                        } else if (co.test(d)) {
                            out.push('<span class="constant">');
                            out.push(d);
                            out.push('</span>');
                        } else if (kw.test(d)) {
                            out.push('<span class="keyword">');
                            out.push(d);
                            out.push('</span>');
                        } else if (fn.test(d)) {
                            out.push('<span class="function">');
                            out.push(d);
                            out.push('</span>');
                        } else {
                            out.push(d)
                        }
                    }
                }
            }
            if (endMarker != "")
                out.push('</span>');
            return out.join("");
        }
    }
});