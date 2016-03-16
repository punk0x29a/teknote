function isMember(key, someTable) return someTable[key]  ~= nil end

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
["set"] = "",
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
["bigtriangleup"] = "\\bigtriangleup ",
["/_\\"] = "\\bigtriangleup ",
["btu"] = "\\bigtriangleup ",
["bu"] = "\\bigtriangleup ",
["btd"] = "\\bigtriangledown ",
["\\-/"] = "\\bigtriangledown ",
["bd"] = "\\bigtriangledown ",
["bigtriangledown"] = "\\bigtriangledown ",
["tl"] = "\\triangleleft ",
["<|"] = "\\triangleleft ",
["triangleleft"] = "\\triangleleft ",
["|>"] = "\\triangleright ",
["triangleright"] = "\\triangleright ",
["O"] = "\\bigcirc ",
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
["!!"] = " ! ",
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
["!subset"] = "\\nsubset ",
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
["imath"] = "\\imath ",
["jmath"] = "\\jmath ",
["ell"] = "\\ell ",
["Re"] = "\\Re ",
["re"] = "\\Re ",
["Im"] = "\\Im ",
["im"] = "\\Im ",
["wp"] = "\\wp ",
["nabla"] = "\\nabla ",
["box"] = "\\Box ",
["Box"] = "\\Box ",
["oo"] = "\\infty ",
["infty"] = "\\infty ",
["-oo"] = "-\\infty",
["-infty"] = "-\\infty",
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
["max"] = "\\max",
["min"] = "\\min",
["sup"] = "\\sup",
["inf"] = "\\inf ",
["ker"] = "\\ker ",
    --BigCommands
["int"] = "\\int ",
["iint"] = "\\iint",
["iiint"] = "\\iiint",
["iiiint"] = "\\iiiint",
["int...int"] = "\\idotsint ", 
["integral"] = "\\int ",
["oint"] = "\\oint ",
["level"] = " \\\\ ",
["wlevel"] = " \\\\ \\color{white}",
["wlvl"] = " \\\\ \\color{white}",
["endsubstack"] = "}} ",
["O+"] = "\\bigoplus ",
["bigoplus"] = "\\bigoplus ",
["O."] = "\\bigodot ",
["bigodot"] = "\\bigodot ",
["Ox"] = "\\bigotimes ",
["bigotimes"] = "\\bigotimes ",
["O*"] = "\\bigotimes ",
["bigcup"] = "\\bigcup ",
["bigsor"] = "\\bigcup ",
["bigsetor"] = "\\bigcup ",
["U"] = "\\bigcup ",
["Setor"] = "\\bigcup ",
["Set+"] = "\\bigcup ",
["Seta"] = "\\bigcap",
["Set*"]= "\\bigcap",
["bigsqcup"] = "\\bigsqcup ",
["big[setor"] = "\\bigsqcup ", 
["big[sor"] = "\\bigsqcup ", 
["coprod"] = "\\coprod ",
["bigwedge"] = "\\bigwedge ",
["endf"] = "",
["endfractions"] = "",
["}}"] = "",
["textrm"] = "\\textrm{",
["exp"] = "\\exp",
["("] = "{{",
[")"] = "}}",
["{"] = "\\{",
["}"] = "\\}",
["over"] = "\\over ",
["/"] = "}\\over{",
["endtabular"] = "\\end{array} ", 
["hline"] = " \\\\ \\hline ", 
["hbar"] = "\\hbar ",
["matrix_separator"] = " & ",
["endmatrix"] = "\\end{matrix}",
["end(matrix"] = "\\end{pmatrix}",
["end[matrix"] = "\\end{bmatrix}",
["end{matrix"] = "\\end{Bmatrix}",
["end|matrix"] = "\\end{vmatrix}",
["end||matrix"] = "\\end{Vmatrix}",
["lvl"] = " \\\\ ",
["tab"] = "\\qquad ",
["qquad"] = "\\qquad ",
["arg"] = "\\arg",
["set"] = "\\{", 
[";"] = "; ", 
[";;"] = "",
["##"] = " ",
["txt"] = "",
["text"] = "", 
["boxed"] = "\\boxed{",
["substack"] = "_{\\substack{",
["root"] = "\\sqrt[",
["sqrt"] = "\\sqrt[",
["fraction"] = "\\cfrac{",
["//"] = "\\cfrac{",
["cfrac"] = "\\cfrac{",
["amatrix"] = " ",
["tabular"] = "\\begin{array}{ ",
["cases"] = "\\begin{cases} ",
["expr"] = "",
["{{"] = "",
["obrace"] = "\\overbrace{",
["overb"] = "\\overbrace{",
["overbrace"] = "\\overbrace{",
["o{"] = "\\overbrace{",
["ubrace"] = "\\underbrace{",
["underb"] = "\\underbrace{",
["underbrace"] = "\\underbrace{",
["u{"] = "\\underbrace{",
["hat"] = "\\hat{",
["overline"] = "\\overline{",
["vec"] = "\\vec{",
["vector"] = "\\vec{",
["bar"] = "\\bar{",
["bigvector"] = "\\overrightarrow{",
["overrightarrow"] = "\\overrightarrow{",
["bvector"] = "\\overrightarrow{",
["bigvec"] = "\\overrightarrow{",
["bvec"] = "\\overrightarrow{",
["oline"] = "\\overline{",
["overl"] = "\\overline{",
["uline"] = "\\underline{",
["underl"] = "\\underline{",
["underline"] = "\\underline{",
["pow"] = "^{",
["^"] = "^{",
["power"] = "^{",
["sub"] = "_{",
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
["intlimits"] = "\\int\\limits_{",
["intl"] = "\\int\\limits_{",
["ointl"] = "\\oint\\limits_{",
["ointlimits"] = "\\oint\\limits_{",
["sum"] = "\\sum_{",
["O+i"] = "\\bigoplus_{ ",
["product"] = "\\prod_{",
["prod"] = "\\prod_{",
["Ui"] = "\\bigcup_{ ",
["Setori"] = "\\bigcup_{",
["Set+i"] = "\\bigcup_{",
["Setai"] = "\\bigcap_{",
["Set*i"]= "\\bigcap_{",
["limits"] = "\\limits_{",
["O.i"] = "\\bigodot_{ ",
["O*i"] = "\\bigotimes_{ ",
["Oxi"] = "\\bigotimes_{ ",
["limit"] = "\\lim_{",
["lim"] = "\\lim_{",
["limes"] = "\\lim_{",
["liminf"] = "\\liminf_{",
["limsup"] = "\\limsup_{",
["log"] = "\\log_{",
["()"] = "\\binom{ ",
["binom"] =" \\binom{ ",
}

dots = {
["..."] = "\\cdots ",
["cdots"] = "\\cdots ",
["dots"] = "\\dots ", 
["v..."] = "\\vdots ",
["vdots"] = "\\vdots ", 
["ddots"] = "\\ddots ", 
["d..."] = "\\ddots ",
}

miscAliases = {
["set"] = "\\{", 
[";"] = "; ", 
[";;"] = "",
["##"] = " ",
["txt"] = "",
["text"] = "", 
["boxed"] = "\\boxed{",
["substack"] = "_{\\substack{",
["root"] = "\\sqrt[",
["sqrt"] = "\\sqrt[",
["fraction"] = "\\cfrac{",
["//"] = "\\cfrac{",
["cfrac"] = "\\cfrac{",
["amatrix"] = " ",
["tabular"] = "\\begin{array}{ ",
["cases"] = "\\begin{cases} ",
["expr"] = "",
["{{"] = "",
["level"] = " \\\\ ",
}

overbraceAliases = {
["obrace"] = "\\overbrace{",
["overb"] = "\\overbrace{",
["overbrace"] = "\\overbrace{",
["o{"] = "\\overbrace{",
}

underbraceAliases = {
["ubrace"] = "\\underbrace{",
["underb"] = "\\underbrace{",
["underbrace"] = "\\underbrace{",
["u{"] = "\\underbrace{",
}

decoratorAliases = { 
["hat"] = "\\hat{",
["overline"] = "\\overline{",
["vec"] = "\\vec{",
["vector"] = "\\vec{",
["bar"] = "\\bar{",
["bigvector"] = "\\overrightarrow{",
["overrightarrow"] = "\\overrightarrow{",
["bvector"] = "\\overrightarrow{",
["bigvec"] = "\\overrightarrow{",
["bvec"] = "\\overrightarrow{",
["oline"] = "\\overline{",
["overl"] = "\\overline{",
["uline"] = "\\underline{",
["underl"] = "\\underline{",
["underline"] = "\\underline{",
["pow"] = "^{",
["^"] = "^{",
["power"] = "^{",
["sub"] = "_{",
}

matrixAliases = {
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
}
    

sigmaAliases = { 
["intlimits"] = "\\int\\limits_{",
["intl"] = "\\int\\limits_{",
["ointl"] = "\\oint\\limits_{",
["ointlimits"] = "\\oint\\limits_{",
["sum"] = "\\sum_{",
["O+i"] = "\\bigoplus_{ ",
["product"] = "\\prod_{",
["prod"] = "\\prod_{",
["Ui"] = "\\bigcup_{ ",
["Setori"] = "\\bigcup_{",
["Set+i"] = "\\bigcup_{",
["Setai"] = "\\bigcap_{",
["Set*i"]= "\\bigcap_{",
["limits"] = "\\limits_{",
["O.i"] = "\\bigodot_{ ",
["O*i"] = "\\bigotimes_{ ",
["Oxi"] = "\\bigotimes_{ ",
}

limitAliases = {
["limit"] = "\\lim_{",
["lim"] = "\\lim_{",
["limes"] = "\\lim_{",
}

coefAliases = {
["liminf"] = "\\liminf_{",
["limsup"] = "\\limsup_{",
["log"] = "\\log_{",
["()"] = "\\binom{ ",
["binom"] =" \\binom{ ",
}

--FUNCTIONS: 

function dictionary() 
    for i,v in pairs(Symbols) do
        print("Token: " .. i .. "\t Symbol: " .. v)
    end
end


--remove all preceding whitespaces, good when autospace is on
--
function checkForPrecedingSpace()
    if spaces or tabs then 
        local h = #result
        if result[h] == "\\: " or result[h] == "\\qquad " then 
            while result[h] == "\\: " or result[h] == "\\qquad " do
            result[h] = ""
            h = h - 1 
            end
        end
    end
end



function nextToken()
    _ = _ + 1 
    currentToken = tokens[_]
end

function isFunction(command)
    return isMember(command,sigmaAliases) or isMember(command,miscAliases) or isMember(comment,coefAliases) or isMember(command,limitAliases) or isMember(command,decoratorAliases) or isMember(command,matrixAliases) or isMember(command,underbraceAliases) or isMember(command,overbraceAliases)
end


--skip spaces until token is encountered, good when autospace is on
--
function skipSpaces()
    if spaces and currentToken == ",," then 
        while _ <= #tokens do 
            nextToken() 
            if currentToken ~= ",," then
                break
            end
        end
    end
end

function isEndSign(offset)
    return tokens[_+offset] == "end" or tokens[_+offset] == "}}"
end

function isNewLevel(offset)
    return tokens[_+offset] == "level" or tokens[_+offset] == "lvl" or tokens[_+offset] == "\\\\"
end

--this launches different functions, invoked by addSymbol
--
function FunctionsCentral()
        if isMember(currentToken,overbraceAliases) then
            overbrace()
        elseif isMember(currentToken,underbraceAliases) then
            underbrace()
        elseif isMember(currentToken,sigmaAliases) then 
            sigmaNotation()
        elseif isMember(currentToken,decoratorAliases) then
            decorate()
        elseif isMember(currentToken,matrixAliases) then 
            matrix()
        elseif isMember(currentToken,limitAliases) then
            limit()
        elseif isMember(currentToken, coefAliases) then 
            coefSymbol() 
        elseif currentToken == "txt" or currentToken ==  "text" then 
            textrm()
        elseif currentToken == "boxed" then
            boxed()
        elseif currentToken == "substack" then 
            substack()
        elseif currentToken == "root" then 
            root()
        elseif currentToken == "sqrt" then
            sqrt()
        elseif currentToken == "amatrix" then
            amatrix()
        elseif currentToken == "tabular" then
            tabular()
        elseif currentToken == "set" then 
            set()
        elseif currentToken == "cases" then 
            cases()
        elseif currentToken == "//" or currentToken == "fraction" or currentToken ==  "cfrac" then 
            fraction()
        elseif currentToken == "endf" or currentToken == "endfractions" then
            endfractions()
        elseif currentToken == "expr" or currentToken == "{{" then
            expr()
        elseif currentToken == "level" or currentToken == "lvl" then 
            level()
        elseif currentToken == "##" then
            comment()
        else 
            table.insert(result, Symbols[currentToken])
        end 
end

function twoMajorLetters()
     return string.len(currentToken) == 2 and string.find(currentToken:sub(1,1), "%u") and currentToken:sub(1,1) == currentToken:sub(2,2)  
end

function addSymbol()
    if isFunction(currentToken) then
        FunctionsCentral()
    elseif isMember(currentToken,Symbols) then 
        table.insert(result, Symbols[currentToken])
    elseif currentToken ~= nil then 
        if twoMajorLetters() then
             mathbb()
        else
            table.insert(result, currentToken)
        end
    end
end

--put a box around text
function boxed()
    table.insert(result, Symbols[currentToken])
    while _ <= #tokens do 
        nextToken() 
        if isEndSign(0) or isNewLevel(0) then
             break
        else
            skipSpaces()
            addSymbol()
        end
    end
    table.insert(result, "}")
end

--this wraps tokens between { and } inserting , in between
function set()
    waslevel = 0;
    table.insert(result, Symbols[currentToken])
    while _ <= #tokens do
        nextToken()
        if isEndSign(0) or isNewLevel(0) then 
            if currentToken == "level" then
                waslevel=1;
                break;
            else
                break
            end
        else 
            skipSpaces()
            addSymbol()
            if _+2 <= #tokens then
                skipSpaces()
                if isEndSign(2) or isNewLevel(2) then 
                    nextToken()
                else
                    table.insert(result, ",")
                    nextToken()
                end
            end
        end
    end
    table.insert(result, "\\}")
    if waslevel == 1 then
                table.insert(result, Symbols["level"]);
    end
end

--overbrace/underbrace tokens and put text above it : overbrace {{ expression }} {{ text }}
function overbrace()
    checkForPrecedingSpace()
    insertThree(Symbols[currentToken],"}^{","}")
end 

function underbrace()
    checkForPrecedingSpace()
    insertThree(Symbols[currentToken],"}^{","}")
end 

--insert newline, useful when autonewline is off 
function level() 
    if color then 
        table.insert(result, " \\\\ " .. color .. " ")
    else
        table.insert(result, " \\\\ ")
    end
end


--determine matrix type 
function setMatrixEndSign()
            if currentToken == "(matrix" or currentToken == "pmatrix" then 
                matrixEndSign = "end(matrix"
            elseif currentToken == "[matrix" or currentToken == "bmatrix" then 
                matrixEndSign = "end[matrix"
            elseif currentToken == "{matrix" or currentToken == "Bmatrix" then 
                matrixEndSign = "end{matrix"
            elseif currentToken == "|matrix" or currentToken == "vmatrix" then 
                matrixEndSign = "end|matrix"
            elseif currentToken == "||matrix" or currentToken == "Vmatrix" then 
                matrixEndSign = "end||matrix"
            else 
                matrixEndSign = "endmatrix" 
            end 
end

--generate matrix from tokens 
function matrix()
            setMatrixEndSign() 
            table.insert(result, Symbols[currentToken])
            while _ <= #tokens do 
                nextToken()
                if isEndSign(0) or _ == #tokens then
                    break
                end
                if isNewLevel(0) then
                    table.insert(result, Symbols["level"])
                elseif currentToken ~= ",," then
                    addSymbol()
                    if _+1 <= #tokens then
                        if not isNewLevel(1) and not isEndSign(1) then 
                            table.insert(result, Symbols["matrix_separator"])
                        end
                    end
                end
            end
            closematrix()
end 

--generate matrix with element numeration
function amatrix()
            nextToken()
            skipSpaces()
            setMatrixEndSign()
            table.insert(result, Symbols[currentToken])
            while _ <= #tokens do 
            nextToken() 
            skipSpaces()
                if isEndSign(0) or _ == #tokens then
                    break
                elseif isNewLevel(0) then
                    table.insert(result, Symbols["level"])
                elseif isMember(currentToken,dots) then 
                    table.insert(result, Symbols[currentToken] )
                    if _+1 <= #tokens then
                        if not isNewLevel(1) and not isEndSign(1) then 
                            table.insert(result, Symbols["matrix_separator"])
                        end
                    end
                else 
                skipSpaces()
                addSymbol()
                checkForPrecedingSpace()
                insertThree("_{",",","}")
                if _+1 <= #tokens then
                        if not isNewLevel(1) then 
                            skipSpaces()
                            table.insert(result, Symbols["matrix_separator"])
                        end
                    end
                end
            end 
            closematrix()
end 

--end matrices accordingly to they type  
function closematrix()
        table.insert(result,Symbols[matrixEndSign])
end


--generate tabular [needs overhaul]
function tabular()
    table.insert(result, Symbols[currentToken])
    skipSpaces()
    columns = 0 
    iterator = _ 
    while Symbols[tokens[iterator]] ~= Symbols["level"] do 
        if tokens[iterator] == "{{" or tokens[iterator] == "expr" then
            while tokens[iterator] ~= "end" and tokens[iterator] ~= "}}" do 
                iterator = iterator + 1 
            end
            columns = columns + 1 
            iterator = iterator + 1 
        elseif spaces == true and tokens[iterator] == ",," then 
            iterator = iterator + 1 
        else
            columns = columns + 1 
            iterator = iterator + 1 
        end
    end
    for i=2, columns do
        result[#result] = result[#result] .. "c|"
    end
        result[#result] = result[#result] .. "c} " 
    while _ <= #tokens do
        nextToken()
        if isEndSign(0) or currentToken == "endtabular" then
            break
        end
        if isNewLevel(0) then 
            table.insert(result, Symbols["hline"] )
        elseif currentToken ~= ",," then
            addSymbol()
            if _+1 <= #tokens then
                        if not isNewLevel(1) and not isEndSign(1) then 
                             table.insert(result, Symbols["matrix_separator"])
                        end
            end
        end
    end
    table.insert(result, Symbols["endtabular"])
end

function expr()
                while _ <= #tokens do 
                    nextToken() 
                    if isEndSign(0) then
                        break
                    else
                        addSymbol()
                    end
                end
end 

function textrm()
                    table.insert(result,Symbols["textrm"])
                    while _ <= #tokens do 
                        nextToken() 
                        if currentToken == "<" then
                            table.insert(result, "\\textless ")
                        elseif currentToken == ">" then 
                            table.insert(result, "\\textgreater ") 
                        elseif currentToken == "|" then 
                            table.insert(result, "\\textbar ")
                        elseif isEndSign(0) or isNewLevel(0) then
                            break
                        else
                                addSymbol()
                                table.insert(result, " ")
                        end
                    end 
                    table.insert(result, "}")
end

function cases()
            table.insert(result, Symbols[currentToken])
            while _ <= #tokens do 
                nextToken() 
                if isEndSign(0) then 
                        break
                elseif isNewLevel(0) then
                    table.insert(result, Symbols["level"])
                elseif currentToken == "expr" or currentToken == "{{" then 
                    expr()
                elseif currentToken == "txt" or currentToken == "text" then 
                    textrm()
                else
                    addSymbol()
                end
            end 
            table.insert(result, "\\end{cases}")
end 


function substack() 
            table.insert(result, Symbols[currentToken])
            while _ <= #tokens do
                nextToken() 
                if isEndSign(0) then
                    break
                elseif isNewLevel(0) then
                    table.insert(result, Symbols["level"])
                else
                    checkForPrecedingSpace()
                    addSymbol()
                end
            end
            checkForPrecedingSpace()
            table.insert(result, Symbols["endsubstack"])
end

function comment()
    while _ <= #tokens do
        nextToken()
        if currentToken == "##" then
            nextToken() 
            break
        end
    end
end

function insertThree(charleft,charmid,charright)
    table.insert(result,charleft)
            nextToken() 
            skipSpaces()
            addSymbol()
    table.insert(result,charmid)
            nextToken() 
            skipSpaces()
            addSymbol()
    table.insert(result,charright)
end


function sigmaNotation() 
            insertThree(Symbols[currentToken],"}^{","}")
end


function root() 
            insertThree(Symbols[currentToken],"]{","}")
end

function sqrt()
            table.insert(result, Symbols[currentToken])
            table.insert(result, "]{")
            nextToken() 
            skipSpaces()
            addSymbol()
            table.insert(result, "}")
end

-- Continous fractions block
function fraction()
            fracn = fracn + 1 
            confrac = true 
            checkForPrecedingSpace()
            table.insert(result, Symbols["fraction"])
            nextToken() 
            skipSpaces()
            addSymbol()
            table.insert(result, "}")
            table.insert(result, "{")
            skipSpaces()
end

function endfractions()
            while fracn > 0 do 
                fracn = fracn - 1 
                table.insert(result, "}")
            end
            confrac = false
end
-- End of continous fractions block

function decorate()
    checkForPrecedingSpace()
    table.insert(result, Symbols[currentToken])
    nextToken() 
    skipSpaces()
    addSymbol()
    table.insert(result, "}")
end 

function coefSymbol()
    checkForPrecedingSpace()
    skipSpaces()
    insertThree(Symbols[currentToken],"}{","}")
end 

function limit()
    checkForPrecedingSpace()
    skipSpaces()
    insertThree(Symbols[currentToken],Symbols["->"],"}")
end

function mathbb()
    table.insert(result, "\\mathbb{")
    table.insert(result,currentToken:sub(1,1))
    table.insert(result, "}")
    --nextToken()
end



--PROGRAM INIT 
color = nil
spaces = true
tabs = true 
newlines = true 
silent=false
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
            print("-c, --color\n\tChoose color, followed by color name, for example \"white\"\n-nn, --nonewlines\n\tDisable automatic adding of \\\\. Use \"lvl\", \"level\" or manually insert \\\\ instead.\n-nt, --notabs\n\t Disable automatic adding of \\qquad. Use \"tab\", or manually insert \\qquad instead.\n-ns, --nospaces\n\tDisable automatic adding of \\:, use \"[]\" \"txt\",\"text\" or manually insert \\: instead. \n-h, --help\n\tDisplay this help message. \n-us, --usage\n\tPrint usage guide.\n-dy, --dictionary\n\tPrint list defined symbols.")
            os.exit(0)
        elseif arg[i] == "-us" or arg[i] == "--usage" then 
            print("Special tokens: \n . - line containing only a single dot signals end of expression.\n ## - signals a beginning, as well as end of a comment. \n expr,{{ - place function as an argument for other function.\n end,}} - end last opened function. \nFunctions:\nmatrix rows end -- generate matrices.\nMatrix types: matrix, (matrix, {matrix, [matrix, |matrix, ||matrix\namatrix matrix_type element number_a number_b end - generate matrices with element numeration\ncases lines end - generate cases\nsub token, substack lines end - adds sub-value to the token\npow, ^ - rises token to the power of value\nlog a b - generates log\nroot a b - generates root\nbinom a b, () a b - generates binomial\nlim a b - generates limit\nsum start upperbound, prod start upperbound - generates sum or product\n// a b endfractions, fraction a b endf, cfrac a b endf - generates continous fractions\ntxt tokens end ,text tokens end - generates plain text\nboxed tokens end - puts a box around text\nunderbrace token text end, overbrace token text end - puts underbrace/overbrace above/beneath token. Text as expr ... end")
            os.exit(0)
        elseif arg[i] == "-dy" or arg[i] == "--dictionary" then
            dictionary()
            os.exit(0)
        elseif arg[i] == "-s" or arg[i] == "--silent" then
            silent=true
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
--
tokens = {};  -- User input tokens 
result = {}; -- Resulting answer tokens 
fracn = 0; -- Number of continous fractions.  
confrac = false; -- Are there any opened continous fractions? 
matrixEndSign = "" -- Matrix type 
_ = 0; -- MOST IMPORTANT VARIABLE 
End_Of_Expression = "."

if(not silent) then
    print("Insert expression: \n\n");
end

local lines = {}
while true do 
    expression = io.read("*l");
    if expression == End_Of_Expression then 
        break
    else
        table.insert(lines, expression)
    end
end

    


--Building table of tokens from input provided by user  
local delimiter; 
for j,v in ipairs(lines) do
    delimiter = 1
    i = 1 
    while i <= v:len() do 
        if i == v:len() then
            if v:sub(i,i) == " " then
                table.insert(tokens,v:sub(delimiter, i-1))
                nextToken()
            else
                table.insert(tokens,v:sub(delimiter, i))
                nextToken()
            end
            nextToken()
        elseif v:sub(i,i) == " " or v:sub(i,i) == "\t" then 
            table.insert(tokens, v:sub(delimiter, i-1))
            nextToken()
            delimiter = i+1
            if v:sub(i,i) == " " and spaces then
                if _ > 0 and currentToken == "substack" or currentToken == "cases" or isMember(currentToken,matrixAliases) then
                    -- do nothing 
                elseif i + 2 <= v:len() then 
                    if v:sub(i+1, i+2) == "}}" then
                        --do nothing
                    else
                        table.insert(tokens, ",,")
                    end
                elseif i + 3 <= v:len() then
                    if v:sub(i+1, i+3) == "end" then
                        --do nothing
                    else
                        table.insert(tokens, ",,")
                    end
                else
                    table.insert(tokens, ",,")
                end
                nextToken()
            elseif v:sub(i,i) == "\t" and tabs then 
                table.insert(tokens, "tab") 
                nextToken()
            end 
        end
        ::continue::
        i = i + 1
    end
    if newlines then
        if currentToken == "tabular" or currentToken == "substack" or currentToken == "cases" or isMember(currentToken,matrixAliases) then 
            -- do nothing
        else
            table.insert(tokens, "level")
        end
    end
end

_ = 0 


while _ <= #tokens do  
    nextToken()
    if confrac then
        skipSpaces()
        if currentToken == "level" then
            nextToken()
        end
    end
    addSymbol()
end 
 
if confrac == true then 
    endfractions()
end

Answer = Answer .. table.concat(result)
if (not silent) then
    print("Resulting expression: \n\n")
end
print(Answer)
