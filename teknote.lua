
function isMember(table, key) return table[key]  ~= nil end

--[[
--  teknote.lua
--  translate commands in relatively simple micro-language into LaTeX math functions
--  ]]


-- Dictionary 
Symbols = { 
    --Binary Operations
["+-"] = "\\pm ",
["-+"] = "\\mp ",
["pm"] = "\\pm ",
["mp"] = "\\mp ",
["**"] = "\\times ",
["times"] = "\\times ",
["*"] = "\\ast ",
["ast"] = "\\ast ",
["***"] = "\\star ",
["star"] = "\\star ",
["::"] = "\\div ",
["div"] = "\\div ",
["dagger"] = "\\dagger ",
["ddagger"] = "\\ddagger ",
["cap"] = "\\cap ",
["setand"] = "\\cap ",
["seta"] = "\\cap ",
["sand"] = "\\cap ",
["set*"] = "\\cap ",
["cup"] = "\\cup ",
["setor"] = "\\cup ",
["sor"] = "\\cup ", 
["set+"] = "\\cup ", 
["u+"] = "\\uplus ",
["uplus"] = "\\uplus",
["sqcap"] = "\\sqcap ",
["[setand"] = "\\sqcap ",
["[sand"] = "\\sqcap ",
["sqcup"] = "\\sqcup ",
["[setand"] = "\\sqcup ",
["[sand"] = "\\sqcup ",
["vee"] = "\\vee ",
["Or"] = "\\bigvee ",
["bigvee"] = "\\bigvee ",
["or"] = "\\vee ", 
["wedge"] = "\\wedge ",
["and"] = "\\wedge ", 
["And"] = "\\bigwedge ",
["bigwedge"] = "\\bigwedge ",
["diamond"] = "\\diamond ",
["bigtriangleup"] = "\\bigtraingleup ",
["btd"] = "\\bigtriangledown ",
["bigtriangledown"] = "\\bigtriangledown ",
["tl"] = "\\triangleleft ",
["triangleleft"] = "\\triangleleft ",
["tr"] = "\\triangleright ",
["triangleright"] = "\\triangleright ",
["bc"] = "\\bigcirc ",
["bigcirc"] = "\\bigcirc ",
["bigcircle"] = "\\bigcircle ", 
["bullet"] = "\\bullet ",
["wr"] = "\\wr ",
["o+"] = "\\oplus ",
["oplus"] = "\\oplus ",
["o-"] = "\\ominus ",
["ominus"] = "\\ominus ",
["o*"] = "\\otimes ",
["ox"] = "\\otimes ",
["otimes"] = "\\otimes ",
["o/"] = "\\oslash ",
["oslash"] = "\\oslash ",
["o."] = "\\odot ",
["odot"] ="\\odot ",
["circ"] = "\\circ ",
["circle"] = "\\circ ",
["o"] = "\\circ ",
["\\"] = "\\setminus ",
["set-"] = "\\setminus ",
["setminus"] = "\\setminus ",
["ip"] = "\\amalg ",
["amalg"] = "\\amalg ",
["##"] = " ",
    --Logic 
["ex"] = "\\exists ",
["nex"] = "\\nexist ",
["!ex"] = "\\nexist ", 
["forall"] = "\\forall ",
["foreach"] = "\\forall ",
["fore"] = "\\forall ",
["fora"] = "\\forall ",
["not"] = "\\neg ",
["!"] = "\\neg ",
["neg"] = "\\neg ",
["and"] = "\\land ",
["land"] = "\\land ",
["or"] = "\\lor ",
["lor"] = "\\lor ",
["->"] = "\\rightarrow ",
["rightarrow"] = "\\rightarrow",
["<-"] = "\\leftarrow ",
["<="] = "\\Leftarrow ",
["leftarrow"] = "\\leftarrow",
["|->"] = "\\mapsto ",
["mapsto"] = "\\mapsto ",
["=>"] = "\\Rightarrow ",
["Rightarrow"] = "\\Rightarrow ",
["<->"] = "\\leftrightarrow ",
["leftrightarrow"] = "\\leftrightarrow ",
["<=>"] = "\\Leftrightarrow ",
["Leftrightarrow"] = "\\Leftrightarrow ",
["top"] = "\\top ",
["true"] = "\\top ",
["bot"] = "\\bot ",
["false"] = "\\bot ",
["bottom"] = "\\bot ", 
["emptyset"] = "\\emptyset ",
["nilset"] = "\\emptyset ",
["nil"] = "\\varnothing ",
["varnothing"] = "\\varnothing",
    --Delimiters 
["/\\"] = "\\uparrow ",
["uparrow"] ="\\uparrow",
["/|\\"] = "\\Uparrow ",
["/||\\"] = "\\Uparrow ",
["Uparrow"] = "\\Uparrow ", 
["\\/"] = "\\downarrow ",
["downarrow"] = "\\downarrow ",
["\\||/"] = "\\Downarrow ",
["\\|/"] = "\\Downarrow ",
["Downarrow"] = "\\Downarrow ",
["((("] = "\\left( ",
["left("] = "\\left( ",
["(("] = "(",
["))"] = ")", 
[")))"] = "\\right) ",
["right)"] = "\\right)",
["[["] = "\\left[ ",
["left["] = "\\left[ ",
["]]"] = "\\right] ",
["right"] = "\\right] ",
["l|"] = "\\left| ",
["left|"] = "\\left| ",
["r|"] = "\\right| ",
["right|"] = "\\right| ",
["m|"] = "\\middle| ",
["middle|"] = "\\middle| ",
["lceil"] = "\\lceil ",
["rceil"] = "\\rceil ",
["lfloor"] = "\\lfloor ",
["rfloor"] = "\\rfloor ",
    --TrigonometricFunctions 
["sin"] = "\\sin ",
["cos"] = "\\cos ",
["tan"] = "\\tan ",
["cot"] = "\\cot ",
["arcsin"] = "\\arcsin ",
["asin"] = "\\arcsin ",
["arccos"] = "\\arccos ",
["acos"] = "\\arccos ",
["arctan"] = "\\arctan ",
["atan"] = "\\arctan ",
["arccot"] = "\\arccot ",
["acot"] = "\\arccot ",
["sinh"] = "\\sinh ",
["cosh"] = "\\cosh ",
["tanh"] = "\\tanh ",
["coth"] = "\\coth ",
["sec"] = "\\sec ",
["csc"] = "\\csc ",
    --Relations
["=<"] = "\\leq ",
["leq"] = "\\leq ",
[">="] = "\\geq ",
["geq"] = "\\geq ",
["<<"] = "\\ll ",
["ll"] = "\\ll ",
[">>"] = "\\gg ",
["gg"] = "\\gg ",
["=="] = "\\equiv ",
["eq"] = "\\equiv ",
["equiv"] = "\\equiv ",
["||"] = "\\parallel ",
["parallel"] = "\\parallel ",
["!||"] = "\\nparallel ",
["nparallel"] = "\\nparallel ",
[".=="] = "\\doteq ",
["doteq"] = "\\doteq ",
["asymp"] = "\\asymp ",
["bowtie"] = "\\bowtie ",
["vdash"] = "\\vdash ",
["outputs"] = "\\vdash ",
["outs"] = "\\vdash ",
["svp"] = "\\dashv ",
["dashv"] = "\\dashv ",
["subset"] = "\\subset ",
["supset"] = "\\supset ",
["superset"] = "\\supset ", 
["~~"] = "\\approx ",
["approx"] = "\\approx ",
["in"] = "\\in ",
["ni"] = "\\ni ",
["=subset"] = "\\subseteq ",
["subset="] = "\\subseteq ",
["subseteq"] = "\\subseteq ",
["=supset"] = "\\supseteq ",
["=superset"] = "\\supseteq ", 
["supset="] ="\\supseteq ",
["superset="] = "\\supseteq ", 
["supseteq"] = "\\supseteq ",
["superseteq"] = "\\supseteq ",
["~=="] = "\\cong ",
["cong"] = "\\cong ",
["smile"] = "\\smile ",
["frown"] = "\\frown ",
["!=subset"] = "\\nsubseteq ",
["nsubseteq"] = "\\nsubseteq ",
["subset!="] = "\\nsubseteq ",
["!=supset"] = "\\nsupseteq ",
["!=superset"] = "\\nsupseteq ",
["nsupseteq"] = "\\nsupseteq ",
["nsuperseteq"] = "\\nsupseteq ",
["supset!="] = "\\nsupseteq ",
["~="] = "\\simeq ",
["simeq"] = "\\simeq ",
["models"] = "\\models ",
["scon"] = "\\models ",
["syntactic_consequence"] = "\\models ",
["notin"] = "\\notin ",
["!in"] = "\\notin ",
["sqsubset"] = "\\sqsubset ",
["[subset"] = "\\sqsubset ", 
["sqsupset"] = "\\sqsupset ",
["sqsuperset"] = "\\sqsupset ",
["[supset"] = "\\sqsupset ",
["[superset"] = "\\sqsupset ",
["~"] = "\\sim ",
["sim"] = "\\sim ",
["perp"] = "\\perp ",
["|"] = "\\mid ",
["=sqsubset"] = "\\sqsubseteq ",
["=[subset"] = "\\sqsubseteq ",
["=sqsupset"] = "\\sqsupseteq ",
["=[superset"] = "\\sqsupseteq ",
["=[supset"] = "\\sqsupseteq ", 
["propto"] = "\\propto ",
["prec"] = "\\prec ",
["succ"] = "\\succ ",
["preceq"] = "\\preceq ",
["succeq"] = "\\succeq ",
["!="] = "\\neq ",
["neq"] = "\\neq ",
    --GreekLetters 
["alpha"] = "\\alpha ",
["beta"] = "\\beta ",
["Beta"] = "\\beta ",
["Gamma"] = "\\Gamma ",
["gamma"] ="\\gamma ",
["Delta"] ="\\Delta ",
["delta"] = "\\delta ",
["epsilon"] = "\\epsilon ",
["vepsilon"] = "\\varepsilon ",
["varepsion"] = "\\varepsilon ",
["zeta"] = "\\zeta ",
["eta"] = "\\eta ",
["Theta"] = "\\Theta ",
["theta"] = "\\theta ",
["vtheta"] = "\\vartheta ",
["iota"] = "\\iota ",
["kappa"] = "\\kappa ",
["vkappa"] = "\\varkappa ",
["varkappa"] ="\\varkappa ",
["Lambda"] = "\\Lambda ",
["lambda"] = "\\lambda ",
["micro"] = "\\mu ",
["mu"] = "\\mu ",
["nu"] = "\\nu ",
["Xi"] = "\\Xi ",
["xi"] = "\\xi ",
["omicron"] = "o ",
["Pi"] = "\\Pi ",
["pi"] = "\\pi ",
["vpi"] = "\\varpi ",
["varpi"] = "\\varpi ",
["ro"] = "\\rho ",
["rho"] = "\\rho ",
["vrho"] = "\\varrho ",
["vro"] = "\\varrho ",
["varrho"] = "\\varrho ",
["Sigma"] = "\\Sigma ",
["sigma"] = "\\sigma ",
["vsigma"] = "\\varsigma ",
["varsigma"] = "\\varsigma ", 
["tau"] = "\\tau ",
["Ypsilon"] = "\\Upsilon ",
["Upsilon"] = "\\Upsilon ",
["ypsilon"] = "\\upsilon ",
["upsilon"] = "\\upsilon ",
["Fi"] = "\\Phi ",
["fi"] = "\\phi ",
["Phi"] = "\\Phi ",
["phi"] = "\\phi ",
["vphi"] = "\\varphi ",
["varphi"] = "\\varphi ",
["chi"] = "\\chi ",
["Psi"] = "\\Psi ",
["psi"] = "\\psi ",
["Omega"] = "\\Omega ",
["omega"] = "\\omega ",
    --OtherSymbols 
["partial"] = "\\partial ",
["eth"] = "\\eth ",
["hbar"] = "\\hbar ",
["imath"] = "\\imath ",
["jmath"] = "\\jmath ",
["ell"] = "\\ell ",
["Re"] = "\\Re ",
["re"] = "\\Re ",
["Im"] = "\\Im ",
["im"] = "\\im ",
["wp"] = "\\wp ",
["nabla"] = "\\nabla ",
["box"] = "\\Box ",
["Box"] = "\\Box ",
["oo"] = "\\infty ",
["infty"] = "\\infty ",
["-oo"] = "-\\infty",
["-infty"] = "-\\infty",
["bar"] = "\\bar{",
[",,"] = "\\: ",
["[]"] = " ", 
["aleph"] = "\\aleph ",
["beth"] = "\\beth ",
["gimel"] = "\\gimel ",
["."] = "\\cdot ",
["..."] = "\\cdots ",
["cdots"] = "\\cdots ",
["dots"] = "\\dots ", 
["v..."] = "\\vdots ",
["vdots"] = "\\vdots ", 
["ddots"] = "\\ddots ", 
["d..."] = "\\ddots ",
["ln"] = "\\ln ",
["log"] = "\\log_{",
["max"] = "\\max",
["min"] = "\\min",
["sup"] = "\\sup",
["liminf"] = "\\liminf_{",
["limsup"] = "\\limsup_{",
["inf"] = "\\inf ",
["ker"] = "\\ker ",
["lim"] = "\\lim_{",
["limit"] = "\\lim_{",
["limes"] = "\\lim_{",
    --BigCommands
["int"] = "\\int ",
["iint"] = "\\iint",
["iiint"] = "\\iiint",
["iiiint"] = "\\iiiint",
["int...int"] = "\\idotsint ", 
["integral"] = "\\int ",
["intlimits"] = "\\int\\limits_{",
["intl"] = "\\int\\limits_{",
["oint"] = "\\oint ",
["ointl"] = "\\oint\\limits_{",
["ointlimits"] = "\\oint\\limits_{",
["substack"] = "_{\\substack{",
["level"] = " \\\\ ",
["wlevel"] = " \\\\ \\color{white}",
["wlvl"] = " \\\\ \\color{white}",
["endsubstack"] = "}} ",
["sum"] = "\\sum ",
["limits"] = "\\limits_{",
["O+i"] = "\\bigoplus_{ ",
["O+"] = "\\bigoplus ",
["bigoplus"] = "\\bigoplus ",
["O.i"] = "\\bigodot_{ ",
["O."] = "\\bigodot ",
["bigodot"] = "\\bigodot ",
["Ox"] = "\\bigotimes ",
["Oxi"] = "\\bigotimes_{ ",
["bigotimes"] = "\\bigotimes ",
["O*"] = "\\bigotimes ",
["O*i"] = "\\bigotimes_{ ",
["bigcup"] = "\\bigcup ",
["bigsor"] = "\\bigcup ",
["bigsetor"] = "\\bigcup ",
["Ui"] = "\\bigcup_{ ",
["U"] = "\\bigcup ",
["Seta"] = "\\bigcap",
["Setai"] = "\\bigcap_{",
["Set*"]= "\\bigcap",
["Set*i"]= "\\bigcap_{",
["bigsqcup"] = "\\bigsqcup ",
["big[setor"] = "\\bigsqcup ", 
["big[sor"] = "\\bigsqcup ", 
["prod"] = "\\prod_{",
["coprod"] = "\\coprod ",
["bigwedge"] = "\\bigwedge ",
["root"] = "\\sqrt[",
["sqrt"] = "\\sqrt[",
["fraction"] = "\\cfrac{",
["//"] = "\\cfrac",
["cfrac"] = "\\cfrac",
["endf"] = "",
["endfractions"] = "",
["sum"] = "\\sum_{",
["expr"] = "",
["{{"] = "",
["}}"] = "",
["textrm"] = "\\textrm{",
["exp"] = "\\exp",
["("] = "{{",
[")"] = "}}",
["{"] = "\\{",
["}"] = "\\}",
["()"] = "\\binom{ ",
["binom"] =" \\binom{ ",
["over"] = "\\over ",
["/"] = "}\\over{",
["amatrix"] = " ",
["matrix"] = "\\begin{matrix} ",
["(matrix"] = "\\begin{pmatrix} ",
["pmatrix"] = "\\begin{pmatrix} ",
["[matrix"] = "\\begin{bmatrix} ",
["bmatrix"] = "\\begin{bmatrix} ",
["{matrix"] = "\\begin{Bmatrix} ",
["Bmatrix"] = "\\begin{Bmatrix} ", 
["|matrix"] = "\\begin{vmatrix} ",
["vmatrix"] = "\\begin{vmatrix} ",
["||matrix"] = "\\begin{Vmatrix} ",
["Vmatrix"] = "\\begin{Vmatrix} ",
["tabular"] = "\\begin{array}{ ",
["endtabular"] = "\\end{array} ", 
["hline"] = " \\\\ \\hline ", 
["pow"] = "^{",
["power"] = "^{",
["sub"] = "_{",
["vec"] = "\\vec{",
["vector"] = "\\vec{",
["bigvector"] = "\\overrightarrow{",
["overrightarrow"] = "\\overrightarrow{",
["bvector"] = "\\overrightarrow{",
["bigvec"] = "\\overrightarrow{",
["bvec"] = "\\overrightarrow{",
["matrix_separator"] = " & ",
["endmatrix"] = "\\end{matrix}",
["end(matrix"] = "\\end{pmatrix}",
["end[matrix"] = "\\end{bmatrix}",
["end{matrix"] = "\\end{Bmatrix}",
["end|matrix"] = "\\end{vmatrix}",
["end||matrix"] = "\\end{Vmatrix}",
["cases"] = "\\begin{cases} ",
["overline"] = "\\overline{",
["oline"] = "\\overline{",
["overl"] = "\\overline{",
["lvl"] = " \\\\ ",
["product"] = "",
["tab"] = "\\qquad ",
["qquad"] = "\\qquad ",
["obrace"] = "\\overbrace{",
["overb"] = "\\overbrace{",
["overbrace"] = "\\overbrace{",
["o{"] = "\\overbrace{",
["ubrace"] = "\\underbrace{",
["underb"] = "\\underbrace{",
["underbrace"] = "\\underbrace{",
["u{"] = "\\underbrace{",
["boxed"] = "\\boxed{",
["arg"] = "\\arg",
["set"] = "\\{", 
["txt"] = "",
["text"] = "", 
[";"] = "; ", 
[";;"] = "",
}

--FUNCTIONS: 

function dictionary() 
    for i,v in pairs(Symbols) do
        print("Token: " .. i .. "\t Symbol: " .. v)
    end
end


--remove all preceding whitespaces, good when autospace is on
function checkForPrecedingSpace()
    if spaces or tabs then 
        local h = #Aparts
        if Aparts[h] == "\\: " or Aparts[h] == "\\qquad " then 
            while Aparts[h] == "\\: " or Aparts[h] == "\\qquad " do
            Aparts[h] = ""
            h = h - 1 
            end
        end
    end
end



--skip spaces until token is encountered, good when autospace is on
function skipSpaces()
    if spaces and parts[_] == ",," then 
        while _ <= #parts do 
            _ = _ + 1 
            if parts[_] ~= ",," then
                break
            end
        end
    end
end

--this launches different functions, invoked by addSymbol
function FunctionsCentral()
    
        if parts[_] == "obrace" or parts[_] == "overb" or parts[_] == "overbrace" or parts[_] == "o{" then
            overbrace()
        elseif parts[_] == "##" then
            comment()
        elseif parts[_] == "ubrace" or parts[_] == "underb" or parts[_] == "underbrace" or parts[_] == "u{" then
            underbrace() 
        elseif parts[_] == "limits" or parts[_] == "intlimits" or parts[_] == "intl" or parts[_] == "ointl" or parts[_] == "ointlimits" or parts[_] == "sum" or parts[_] == "U+i" or parts[_] == "U.i" or parts[_] == "Uxi" or parts[_] == "U*i" or parts[_] == "Setai" or parts[_] == "Set*i" or parts[_] == "Ui" or parts[_] == "prod" or parts[_] == "product" or parts[_] == "limits" then 
        sumsandlimits()
        elseif parts[_] == "bar" or  parts[_] == "pow" or parts[_] == "overrightarrow" or parts[_] == "power" or parts[_] == "overline" or parts[_] == "overl" or parts[_] == "oline" or parts[_] == "vector" or parts[_] == "vec" or parts[_] == "bigvector" or parts[_] == "bvec" or parts[_] == "bvector" or parts[_] == "bigvec" or parts[_] == "sub" then
            curlyBracedSymbol()
        elseif parts[_] == "txt" or parts[_] ==  "text" then 
            textrm()
        elseif parts[_] == "boxed" then
            boxed()
        elseif parts[_] == "substack" then 
            substack()
        elseif parts[_] == "root" then 
            root()
        elseif parts[_] == "sqrt" then
            sqrt()
        elseif parts[_] == "amatrix" then
            amatrix()
        elseif parts[_] == "tabular" then
            tabular()
        elseif parts[_] == "set" then 
            set()
        elseif parts[_] == "matrix" or parts[_] == "|matrix" or parts[_] == "(matrix" or  parts[_] == "pmatrix" or parts[_] == "bmatrix" or parts[_] == "Bmatrix" or parts[_] == "vmatrix" or parts[_] == "Vmatrix" or parts[_] == "{matrix" or parts[_] == "[matrix" or parts[_] == "||matrix" then 
            matrix()
        elseif parts[_] == "cases" then 
            cases()
        elseif parts[_] == "//" or parts[_] == "fraction" or parts[_] ==  "cfrac" then 
            fraction()
        elseif parts[_] == "endf" or parts[_] == "endfractions" then
            endfractions()
        elseif parts[_] == "lim" then
            limit()
        elseif parts[_] == "log" or parts[_] == "limes" or parts[_] == "limit" or parts[_] == "limsup" or parts[_] == "liminf" or parts[_] == "binom" or parts[_] == "()" then 
            doublyCurlyBracedSymbol() 
        elseif parts[_] == "end" then 
        elseif parts[_] == "expr" or parts[_] == "{{" or parts[_] == ";;" then
            expr()
        elseif parts[_] == "level" or parts[_] == "lvl" then 
            level()
        else 
            table.insert(Aparts, Symbols[parts[_]])
        end 
end


function addSymbol()
    if isMember(Symbols,parts[_]) then
        FunctionsCentral()
    else
        if parts[_] ~= nil then 
            if string.len(parts[_]) == 2 then
                if string.find(parts[_]:sub(1,1), "%u") and parts[_]:sub(1,1) == parts[_]:sub(2,2) then

                     mathbb()
             else
                    table.insert(Aparts, parts[_])
                 end
             else
                    table.insert(Aparts, parts[_])
            end
        end
    end
end

--this wraps tokens between { and } inserting , in between
function set()
    table.insert(Aparts, Symbols[parts[_]])
    while _ <= #parts do
        _ = _ + 1
        if parts[_] == "end" or parts[_] == "level" or parts[_] == ";" then 
            break
        end
        skipSpaces()
        addSymbol()
            if _+1 <= #parts then
                if parts[_+1] ~= "end" and parts[_+1] ~= "level" and parts[_+1] ~= ";" then 
                    table.insert(Aparts, ",")
                end
            end
    end
    table.insert(Aparts, "\\}")
end

--put a box around text
function boxed()
    table.insert(Aparts, Symbols[parts[_]])
    while _ <= #parts do 
        _ = _ + 1 
        if parts[_] == "end" or parts[_] == "level" or parts[_] == ";" then
             break
        else
            skipSpaces()
            addSymbol()
        end
    end
    table.insert(Aparts, "}")
end

--overbrace/underbrace tokens and put text above it : overbrace {{ expression }} {{ text }}
function overbrace()
    checkForPrecedingSpace()
    table.insert(Aparts, Symbols[parts[_]])
    _ = _ + 1 
    skipSpaces()
    addSymbol()
    table.insert(Aparts, "}^\\text{")
    _ = _ + 1 
    skipSpaces()
    addSymbol()
    table.insert(Aparts, "}")
end 

function underbrace()
    checkForPrecedingSpace()
    table.insert(Aparts, Symbols[parts[_]])
    _ = _ + 1
    skipSpaces()
    addSymbol()
    table.insert(Aparts, "}_{")
    _ = _ + 1 
    skipSpaces()
    addSymbol()
    table.insert(Aparts, "}")
end 

--insert newline, useful when autonewline is off 
function level() 
    if color then 
        table.insert(Aparts, " \\\\ " .. color .. " ")
    else
        table.insert(Aparts, " \\\\ ")
    end
end


--determine matrix type 
function setmswitch()
            if parts[_] == "(matrix" or parts[_] == "pmatrix" then 
                mswitcher = 1
            elseif parts[_] == "[matrix" or parts[_] == "bmatrix" then 
                mswitcher = 2
            elseif parts[_] == "{matrix" or parts[_] == "Bmatrix" then 
                mswitcher = 3 
            elseif parts[_] == "|matrix" or parts[_] == "vmatrix" then 
                mswitcher = 4
            elseif parts[_] == "||matrix" or parts[_] == "Vmatrix" then 
                mswitcher = 5 
            else 
                mswitcher = 0 
            end 
end

--generate matrix from tokens 
function matrix()
            setmswitch() 
            table.insert(Aparts, Symbols[parts[_]])
            while _ <= #parts do 
                _ = _ + 1
                if parts[_] == ";" or parts[_] == "end" then
                    break
                end
                if parts[_] == "level" or parts[_] == "lvl" or parts[_] == "\\\\" then
                    table.insert(Aparts, Symbols["level"])
                elseif parts[_] ~= ",," then
                    addSymbol()
                    if _+1 <= #parts then
                        if parts[_+1] ~= "level" and parts[_+1] ~= "lvl" and parts[_+1] ~= "\\\\" and parts[_+1] ~= "end" and parts[_+1] ~= ";" then 
                            table.insert(Aparts, Symbols["matrix_separator"])
                        end
                    end
                end
            end
            closematrix()
end 

--generate matrix with element numeration
function amatrix()
            _ = _ + 1
            skipSpaces()
            setmswitch()
            table.insert(Aparts, Symbols[parts[_]])
            while _ <= #parts do 
            _ = _ + 1 
            skipSpaces()
                if parts[_] == "end" or parts[_] == ";" or _ == #parts then
                    break
                elseif parts[_] == "level" or parts[_] == "lvl" or parts[_] == "\\\\" then
                    table.insert(Aparts, Symbols["level"])
                elseif parts[_] == "..." or parts[_] == "dots" or parts[_] == "cdots" or parts[_] == "ddots" or parts[_] == "vdots" or parts[_] == "v..." or parts[_] == "d..." then 
                    table.insert(Aparts, Symbols[parts[_]] )
                    if _+1 <= #parts then
                        if parts[_+1] ~= "level" and parts[_+1] ~= "lvl" and parts[_+1] ~= "\\\\" and parts[_+1] ~= "end" and parts[_+1] ~= ";" then 
                            table.insert(Aparts, Symbols["matrix_separator"])
                        end
                    end
                else 
                    skipSpaces()
                        addSymbol()
                checkForPrecedingSpace()
                        table.insert(Aparts, "_{")
                        _ = _ + 1 
                    skipSpaces()
                        addSymbol()
                        table.insert(Aparts, ",")
                        _ = _ + 1
                    skipSpaces()
                        addSymbol()
                        table.insert(Aparts, "}")
                        if _+1 <= #parts then
                            if parts[_+1] ~= "level" and parts[_] ~= "lvl" and parts[_] ~= "\\\\" then 
                    skipSpaces()
                                table.insert(Aparts, Symbols["matrix_separator"])
                            end
                        end
                end
            end 
            closematrix()
end 

--end matrices accordingly to they type  
function closematrix()
            if mswitcher == 1 then 
                table.insert(Aparts, Symbols["end(matrix"])
            elseif mswitcher == 2 then 
                table.insert(Aparts, Symbols["end[matrix"])
            elseif mswitcher == 3 then 
                table.insert(Aparts, Symbols["end{matrix"])
            elseif mswitcher == 4 then
                table.insert(Aparts, Symbols["end|matrix"])
            elseif mswitcher == 5 then 
                table.insert(Aparts, Symbols["end||matrix"])
            else 
                table.insert(Aparts, Symbols["endmatrix"])
            end 
end


--generate tabular [needs overhaul]
function tabular()
    table.insert(Aparts, Symbols[parts[_]])
    skipSpaces()
    columns = 0 
    iterator = _ 
    while Symbols[parts[iterator]] ~= Symbols["level"] do 
        if parts[iterator] == "{{" or parts[iterator] == ";" or parts[iterator] == "expr" then
            while parts[iterator] ~= ";" and parts[iterator] ~= "end" and parts[iterator] ~= "}}" do 
                iterator = iterator + 1 
            end
            columns = columns + 1 
            iterator = iterator + 1 
        elseif spaces == true and parts[iterator] == ",," then 
            iterator = iterator + 1 
        else
            columns = columns + 1 
            iterator = iterator + 1 
        end
    end
    for i=2, columns do
        Aparts[#Aparts] = Aparts[#Aparts] .. "c|"
    end
        Aparts[#Aparts] = Aparts[#Aparts] .. "c} " 
    while _ <= #parts do
        _ = _ + 1
        if parts[_] == ";" or parts[_] == "end" or parts[_] == "endtabular" then
            break
        end
        if parts[_] == "level" or parts[_] == "lvl" or parts[_] == "\\\\" then 
            table.insert(Aparts, Symbols["hline"] )
        elseif parts[_] ~= ",," then
            addSymbol()
                if _+1 <= #parts then
                            if parts[_+1] ~= "level" and parts[_+1] ~= "lvl" and parts[_+1] ~= "\\\\" and parts[_+1] ~= "end" and parts[_+1] ~= ";" then 
                                 table.insert(Aparts, Symbols["matrix_separator"])
                            end
                end
        end
    end
    table.insert(Aparts, Symbols["endtabular"])
end
                

function expr()
                while _ <= #parts do 
                    _ = _ + 1 
                    if parts[_] == "end" or parts[_] == "}}" or parts[_] == ";" then
                        break
                    else
                        addSymbol()
                    end
                end
end 

function textrm()
                    table.insert(Aparts,Symbols["textrm"])
                    while _ <= #parts do 
                        _ = _ + 1 
                        if parts[_] == "<" then
                            table.insert(Aparts, "\\textless ")
                        elseif parts[_] == ">" then 
                            table.insert(Aparts, "\\textgreater ") 
                        elseif parts[_] == "|" then 
                            table.insert(Aparts, "\\textbar ")
                        elseif parts[_] == "end" or parts[_] == "level" then
                            break
                        else
                                addSymbol()
                                table.insert(Aparts, " ")
                        end
                    end 
                    table.insert(Aparts, "}")
end

function cases()
            table.insert(Aparts, Symbols[parts[_]])
            while _ <= #parts do 
                _ = _ + 1 
                if parts[_] == "end" or parts[_] == ";" then 
                        break
                elseif parts[_] == "level" or parts[_] == "lvl" or parts[_] == "\\\\" then
                    table.insert(Aparts, Symbols["level"])
                elseif parts[_] == "expr" or parts[_] == "{{" or parts[_] == ";;" then 
                    expr()
                elseif parts[_] == "txt" or parts[_] == "text" then 
                    textrm()
                else
                    addSymbol()
                end
            end 
            table.insert(Aparts, "\\end{cases}")
end 


function substack() 
            table.insert(Aparts, Symbols[parts[_]])
                while _ <= #parts do
                    _ = _ + 1 
                    if parts[_] == "end" or parts[_] == ";" then
                        break
                    elseif parts[_] == "level" or parts[_] == "lvl" or parts[_] == "\\\\" then
                        table.insert(Aparts, Symbols["level"])
                    else
                        checkForPrecedingSpace()
                        addSymbol()
                    end
                end
                checkForPrecedingSpace()
            table.insert(Aparts, Symbols["endsubstack"])
end

function comment()
    while _ <= #parts do
        _ = _ + 1
        if parts[_] == "##" then
            _ = _ + 1 
            break
        end
    end
end
function sumsandlimits() 
            table.insert(Aparts, Symbols[parts[_]])
            _ = _ + 1 
            skipSpaces()
            addSymbol()
            table.insert(Aparts, "}^{")
            _ = _ + 1 
            skipSpaces()
            addSymbol()
            table.insert(Aparts, "}")
end


-- Probably 
function root() 
            table.insert(Aparts, Symbols[parts[_]])
            _ = _ + 1 
        skipSpaces()
            addSymbol()
            table.insert(Aparts, "]{")
            _ = _ + 1 
        skipSpaces()
            addSymbol()
            table.insert(Aparts, "}")
end

function sqrt()
        table.insert(Aparts, Symbols[parts[_]])
            table.insert(Aparts, "]{")
            _ = _ + 1 
            skipSpaces()
            addSymbol()
            table.insert(Aparts, "}")
end

-- Continous fractions block
function fraction()
            fracn = fracn + 1 
            confrac = true 
            checkForPrecedingSpace()
            table.insert(Aparts, Symbols["fraction"])
            _ = _ + 1 
            skipSpaces()
            addSymbol()
            table.insert(Aparts, "}")
            table.insert(Aparts, "{")
            skipSpaces()
end

function endfractions()
            while fracn > 0 do 
                fracn = fracn - 1 
                table.insert(Aparts, "}")
            end
            confrac = false
end
-- End of continous fractions block

function curlyBracedSymbol()
    checkForPrecedingSpace()
    table.insert(Aparts, Symbols[parts[_]])
    _ = _ + 1 
    skipSpaces()
    addSymbol()
    table.insert(Aparts, "}")
end 

function doublyCurlyBracedSymbol()
    checkForPrecedingSpace()
    skipSpaces()
            table.insert(Aparts, Symbols[parts[_]])
            _ = _ + 1 
        skipSpaces()
            addSymbol()
            table.insert(Aparts, "}{")
            _ = _ + 1
        skipSpaces()
            addSymbol()
            table.insert(Aparts, "}")
end 

function limit()
    checkForPrecedingSpace()
    skipSpaces()
    table.insert(Aparts, Symbols[parts[_]])
    _ = _ + 1 
    skipSpaces()
    addSymbol()
    table.insert(Aparts, Symbols["->"])
    _ = _ + 1
    skipSpaces()
    addSymbol()
    table.insert(Aparts, "}")
end

function mathbb()
    table.insert(Aparts, "\\mathbb{")
    table.insert(Aparts,parts[_]:sub(1,1))
    table.insert(Aparts, "}")
    _ = _ + 1
end
color = nil
spaces = true
tabs = true 
newlines = true 
local i = 1
while i <= #arg do   
        if arg[i] == "-c" or arg[i] == "--color" then
            color = "\\color{" .. arg[i+1] .. "}"
        elseif arg[i] == "--nospaces" or arg[i] == "-ns" then
            spaces = false
            ns = true
        elseif arg[i] == "--notabs" or arg[i] == "-nt" then
            tabs = false
            nt = true 
        elseif arg[i] == "--nonewlines" or arg[i] == "-nn" then
            newlines = false
        elseif arg[i] == "-h" or arg[i] == "--help" then 
            print("-nn, --nonewlines\n\tDisable automatic adding of \\\\. Use \"lvl\", \"level\" or manually insert \\\\ instead.\n-nt, --notabs\n\t Disable automatic adding of \\qquad. Use \"tab\", or manually insert \\qquad instead.\n-ns, --nospaces\n\tDisable automatic adding of \\:, use \"[]\" \"txt\",\"text\" or manually insert \\: instead. \n-h, --help\n\tDisplay this help message. \n-us, --usage\n\tPrint usage guide.\n-dy, --dictionary\n\tPrint list defined symbols.")
            os.exit(0)
        elseif arg[i] == "-us" or arg[i] == "--usage" then 
            print("Special tokens: \n . - line containing only a single dot signals end of expression.\nexpr,{{, ;; - place function as an argument for other function.\nend,}},; - end last opened function. \nFunctions:\nmatrix rows end -- generate matrices.\nMatrix types: matrix, (matrix, {matrix, [matrix, |matrix, ||matrix\namatrix matrix_type element number_a number_b end - generate matrices with element numeration\ncases lines end - generate cases\nsub token, substack lines end - adds sub-value to the token\npow, ^ - rises token to the power of value\nlog a b - generates log\nroot a b - generates root\nbinom a b, () a b - generates binomial\nlim expr - generates limit\nsum start upperbound, prod start upperbound - generates sum or product\n// a b endfractions, fraction a b endf, cfrac a b endf - generates continous fractions\ntxt tokens end ,text tokens end - generates plain text\nboxed tokens end - puts a box around text\nunderbrace token text end, overbrace token text end - puts underbrace/overbrace above/beneath token. Text as expr ... end")
            os.exit(0)
        elseif arg[i] == "-dy" or arg[i] == "--dictionary" then
            dictionary()
            os.exit(0)
        end
        i = i + 1
end

-- ENV variables

if color then 
    Answer = color
else
    Answer = ""
end
-- Global variables 
parts = {};  -- User input tokens 
Aparts = {}; -- Resulting answer tokens 
fracn = 0; -- Number of continous fractions.  
confrac = false; -- Are there not yet closed continous fractions? 
mswitcher = 0; -- Matrix type 
_ = 0; -- MOST IMPORTANT VARIABLE 
End_Of_Expression = "."
print("Insert expression: \n\n");
local lines = {}
while true do 
    expression = io.read("*l");
    if expression == End_Of_Expression then 
        break
    else
        table.insert(lines, expression)
    end
end

    


--Building table of tokens from a string provided by script user  
local delimiter; 
for j,v in ipairs(lines) do
    delimiter = 1
    i = 1 
    while i <= v:len() do 
        if i == v:len() then
            if v:sub(i,i) == " " then
                table.insert(parts,v:sub(delimiter, i-1))
            else
                table.insert(parts,v:sub(delimiter, i))
            end
            _ = _ + 1
        elseif v:sub(i,i) == " " or v:sub(i,i) == "\t" then 
            table.insert(parts, v:sub(delimiter, i-1))
            _ = _ + 1
            delimiter = i+1
            if v:sub(i,i) == " " and spaces then
                if _ > 0 and parts[_] == "substack" or parts[_] == "cases" or parts[_] == "amatrix" or parts[_] == "matrix" or parts[_] == "|matrix" or parts[_] == "(matrix" or  parts[_] == "pmatrix" or parts[_] == "bmatrix" or parts[_] == "Bmatrix" or parts[_] == "vmatrix" or parts[_] == "Vmatrix" or parts[_] == "{matrix" or parts[_] == "[matrix" or parts[_] == "||matrix" then
                    --
                elseif i+1 <= v:len() then 
                    if v:sub(i+1,i+1) == ";" then
                        -- do nothing
                    else
                        table.insert(parts, ",,")
                    end
                elseif i + 2 <= v:len() then 
                    if v:sub(i+1, i+2) == "}}" then
                        --do nothing
                    else
                        table.insert(parts, ",,")
                    end
                elseif i + 3 <= v:len() then
                    if v:sub(i+1, i+3) == "end" then
                        --do nothing
                    else
                        table.insert(parts, ",,")
                    end
                else
                        table.insert(parts, ",,")
                end
                _ = _ + 1
            elseif v:sub(i,i) == "\t" and tabs then 
                table.insert(parts, "tab") 
                _ = _ + 1
            end 
        end
        ::continue::
        i = i + 1
    end
    if newlines then
        if parts[_] == "tabular" or parts[_] == "substack" or parts[_] == "cases" or parts[_] == "amatrix" or parts[_] == "matrix" or parts[_] == "|matrix" or parts[_] == "(matrix" or  parts[_] == "pmatrix" or parts[_] == "bmatrix" or parts[_] == "Bmatrix" or parts[_] == "vmatrix" or parts[_] == "Vmatrix" or parts[_] == "{matrix" or parts[_] == "[matrix" or parts[_] == "||matrix" then 
            -- do nothing
        else
            table.insert(parts, "level")
        end
    end
end

_ = 0 



while _ <= #parts do  
    _ = _ + 1
    if confrac then
        skipSpaces()
        if parts[_] == "level" then
            _ = _ + 1
        end
    end
    addSymbol()
end 
 
if confrac == true then 
endfractions()
end

Answer = Answer .. table.concat(Aparts)
print("Resulting expression: \n\n")
print(Answer)
