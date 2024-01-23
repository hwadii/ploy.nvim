local lush = require('lush')
local hsl = lush.hsl

local colors = {
  -- Basic
  bg = hsl("#1a1a19"),
  fg = hsl("#d1d1d1"),
  -- Normal
  black = hsl("#1a1a19"),
  red = hsl("#ff968c"),
  green = hsl("#61957f"),
  yellow = hsl("#ffc591"),
  blue = hsl("#8db4d4").de(30),
  magenta = hsl("#de9bc8"),
  cyan = hsl("#7bb099"),
  white = hsl("#d1d1d1"),
  -- Bright
  bright_black = hsl("#4c4c4b"),
  bright_red = hsl("#ffafa5"),
  bright_green = hsl("#7aae98"),
  bright_yellow = hsl("#ffdeaa"),
  bright_blue = hsl("#a6cded"),
  bright_magenta = hsl("#f7b4e1"),
  bright_cyan = hsl("#94c9b2"),
  bright_white = hsl("#eaeaea"),
}

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym

  return {
    -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
    -- groups, mostly used for styling UI elements.
    -- Comment them out and add your own properties to override the defaults.
    -- An empty definition `{}` will clear all styling, leaving elements looking
    -- like the 'Normal' group.
    -- To be able to link to a group, it must already be defined, so you may have
    -- to reorder items as you go.
    --
    -- See :h highlight-groups
    --
    Normal       { fg = colors.fg, bg = colors.bg }, -- Normal text
    NormalFloat  { Normal, bg = hsl("#000000").li(2) }, -- Normal text in floating windows.
    NormalNC     { Normal, bg = Normal.bg.li(2) }, -- normal text in non-current windows
    Conceal      { fg = colors.fg.da(30), gui = "bold, italic" }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    CursorLine   { bg = colors.bg.li(4) }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
    CursorColumn { CursorLine }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    ColorColumn  { bg = colors.bg.saturation(2).lightness(20) }, -- Columns set with 'colorcolumn'
    Directory    { gui = "bold" }, -- Directory names (and other special names in listings)
    DiffAdd      { bg = colors.green.da(40).de(30) }, -- Diff mode: Added line |diff.txt|
    DiffChange   { bg = colors.blue.da(70) }, -- Diff mode: Changed line |diff.txt|
    DiffDelete   { bg = colors.red.de(60).da(40) }, -- Diff mode: Deleted line |diff.txt|
    DiffText     { bg = colors.blue.da(50) }, -- Diff mode: Changed text within a changed line |diff.txt|
    NonText      { fg = colors.bg.li(20) }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    EndOfBuffer  { NonText }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    SpecialKey   { NonText, gui = 'italic' }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    Whitespace   { NonText }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    Cursor       { bg = colors.fg.li(20), fg = colors.bg }, -- Character under the cursor
    lCursor      { Cursor, bg = Cursor.bg.da(30) }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    CursorIM     { Cursor }, -- Like Cursor, but used when in IME mode |CursorIM|
    TermCursor   { Cursor }, -- Cursor in a focused terminal
    TermCursorNC { lCursor }, -- Cursor in an unfocused terminal
    Error        { fg = colors.red }, -- Any erroneous construct
    ErrorMsg     { Error }, -- Error messages on the command line
    LineNr       { fg = colors.bg.li(30) }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr { CursorLine, gui = "bold" }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    VertSplit    { fg = LineNr.fg }, -- Column separating vertically split windows
    Folded       { fg = colors.bg.li(64), bg = colors.bg.li(14) }, -- Line used for closed folds
    FoldColumn   { LineNr, gui = "bold" }, -- 'foldcolumn'
    SignColumn   { LineNr }, -- Column where |signs| are displayed
    Search       { fg = colors.fg.da(16), bg = colors.yellow.da(80) }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    IncSearch    { fg = colors.bright_white, bg = colors.yellow.da(60) }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    CurSearch    { IncSearch },
    -- Substitute   { }, -- |:substitute| replacement text highlighting
    MatchParen   { fg = colors.magenta, gui = "bold" }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    -- ModeMsg      { }, -- 'showmode' message (e.g., "-- INSERT -- ")
    -- MsgArea      { }, -- Area for messages and cmdline
    MsgSeparator { VertSplit }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg      { fg = colors.green, gui = "bold" }, -- |more-prompt|
    Pmenu        { NormalFloat }, -- Popup menu: Normal item.
    PmenuSel     { NormalFloat, bg = NormalFloat.bg.li(12)}, -- Popup menu: Selected item.
    PmenuSbar    { NormalFloat, bg = NormalFloat.bg.li(16) }, -- Popup menu: Scrollbar.
    PmenuThumb   { NormalFloat, bg = NormalFloat.bg.li(30) }, -- Popup menu: Thumb of the scrollbar.
    FloatBorder  { NormalFloat },
    Question     { MoreMsg }, -- |hit-enter| prompt and yes/no questions
    -- QuickFixLine { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    SpellBad     { fg = colors.red, gui = "undercurl" }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap     { fg = colors.red, gui = "undercurl" }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal   { fg = colors.red, gui = "undercurl" }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare    { fg = colors.red, gui = "undercurl" }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
    StatusLine   { Normal, bg = colors.bg.li(6) }, -- Status line of current window
    StatusLineNC { Normal, bg = colors.bg.li(10), gui = "italic" }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine      { Normal, bg = colors.bg.li(10) }, -- Tab pages line, not active tab page label
    TabLineFill  { Normal }, -- Tab pages line, where there are no labels
    TabLineSel   { gui = "bold" }, -- Tab pages line, active tab page label
    Title        { gui = "bold" }, -- Titles for output from ":set all", ":autocmd" etc.
    Visual       { bg = colors.cyan.da(70) }, -- Visual mode selection
    -- VisualNOS    { }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg   { fg = colors.yellow }, -- Warning messages
    Winseparator { VertSplit }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
    WildMenu     { fg = colors.bg, bg = colors.yellow.li(30).da(60) }, -- Current match in 'wildmenu' completion

    -- Common vim syntax groups used for all kinds of code and markup.
    -- Commented-out groups should chain up to their preferred (*) group
    -- by default.
    --
    -- See :h group-name
    --
    -- Uncomment and edit if you want more specific syntax highlighting.

    Comment        { fg = colors.bg.li(32), gui = "italic" }, -- Any comment

    Constant       { fg = colors.bright_cyan }, -- (*) Any constant
    -- String         {  }, --   A string constant: "this is a string"
    -- Character      { }, --   A character constant: 'c', '\n'
    Number         { Constant }, --   A number constant: 234, 0xff
    Boolean        { Constant }, --   A boolean constant: TRUE, false
    -- Float          { }, --   A floating point constant: 2.3e10

    Identifier     { fg = colors.fg.da(10) }, -- (*) Any variable name
    Function       { fg = colors.fg }, --   Function name (also: methods for classes)

    Statement      { fg = colors.blue, gui = "bold" }, -- (*) Any statement
    Conditional    { Statement, gui = "NONE" }, --   if, then, else, endif, switch, etc.
    Repeat         { Conditional }, --   for, do, while, etc.
    Label          { Conditional }, --   case, default, etc.
    Operator       { fg = colors.bright_yellow }, --   "sizeof", "+", "*", etc.
    Keyword        { Conditional }, --   any other keyword
    Exception      { Statement }, --   try, catch, throw

    PreProc        { Statement }, -- (*) Generic Preprocessor
    -- Include        { }, --   Preprocessor #include
    -- Define         { }, --   Preprocessor #define
    -- Macro          { }, --   Same as Define
    -- PreCondit      { }, --   Preprocessor #if, #else, #endif, etc.

    Type           { fg = colors.yellow.da(10) }, -- (*) int, long, char, etc.
    -- StorageClass   { }, --   static, register, volatile, etc.
    -- Structure      { }, --   struct, union, enum, etc.
    -- Typedef        { }, --   A typedef

    Special        { fg = colors.bg.li(40) }, -- (*) Any special symbol
    -- SpecialChar    { }, --   Special character in a constant
    -- Tag            { }, --   You can use CTRL-] on this
    Delimiter      { Special }, --   Character that needs attention
    SpecialComment { Comment, gui = "NONE" }, --   Special things inside a comment (e.g. '\n')
    -- Debug          { }, --   Debugging statements

    Underlined     { gui = "underline" }, -- Text that stands out, HTML links
    Bold           { gui = "bold" },
    Italic         { gui = "italic" },
    -- Ignore         { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
    Todo           { gui = "bold, underline" }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client and diagnostic system. Some
    -- other LSP clients may use these groups, or use their own. Consult your
    -- LSP client's documentation.

    -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
    --
    LspReferenceText            { ColorColumn } , -- Used for highlighting "text" references
    LspReferenceRead            { LspReferenceText } , -- Used for highlighting "read" references
    LspReferenceWrite           { LspReferenceText } , -- Used for highlighting "write" references
    LspCodeLens                 { LineNr } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    LspCodeLensSeparator        { Delimiter } , -- Used to color the seperator between two or more code lens.
    LspSignatureActiveParameter { gui = "bold, italic" } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

    -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
    --
    DiagnosticError            { fg = colors.red } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticWarn             { fg = colors.bright_yellow } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticInfo             { fg = colors.bright_blue } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticHint             { fg = colors.bright_green } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticOk               { fg = colors.green } ,
    DiagnosticDeprecated       { gui = "strikethrough" },
    DiagnosticVirtualTextError { DiagnosticError, gui = "italic" } , -- Used for "Error" diagnostic virtual text.
    DiagnosticVirtualTextWarn  { DiagnosticWarn, gui = "italic"} , -- Used for "Warn" diagnostic virtual text.
    DiagnosticVirtualTextInfo  { DiagnosticInfo, gui = "italic"} , -- Used for "Info" diagnostic virtual text.
    DiagnosticVirtualTextHint  { DiagnosticHint, gui = "italic"} , -- Used for "Hint" diagnostic virtual text.
    DiagnosticVirtualTextOk    { DiagnosticOk, gui = "italic" } ,
    DiagnosticUnderlineError   { sp = colors.red, gui = "undercurl" } , -- Used to underline "Error" diagnostics.
    DiagnosticUnderlineWarn    { sp = DiagnosticWarn.fg, gui = "underline" } , -- Used to underline "Warn" diagnostics.
    DiagnosticUnderlineInfo    { sp = DiagnosticInfo.fg, gui = "underline" } , -- Used to underline "Info" diagnostics.
    DiagnosticUnderlineHint    { sp = DiagnosticHint.fg, gui = "underline" } , -- Used to underline "Hint" diagnostics.
    DiagnosticUnderlineOk      { sp = DiagnosticOk.fg, gui = "underline" } ,
    -- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
    -- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
    -- DiagnosticSignError        { } , -- Used for "Error" signs in sign column.
    -- DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.
    -- DiagnosticSignInfo         { } , -- Used for "Info" signs in sign column.
    -- DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.

    -- Tree-Sitter syntax groups. Most link to corresponding
    -- vim syntax groups (e.g. TSKeyword => Keyword) by default.
    --
    -- See :h nvim-treesitter-highlights, some groups may not be listed, submit a PR fix to lush-template!
    --
    sym("@variable")                     { Identifier },
    sym("@variable.builtin")             { Identifier, gui = 'italic' },
    sym("@variable.parameter")           { sym "@variable" },
    sym("@variable.member")              { sym "@variable" },

    sym("@constant")                     { Constant },
    sym("@constant.builtin")             { sym "@constant" },
    sym("@constant.macro")               { sym "@constant" },

    sym("@module")                       { Type },
    sym("@module.builtin")               { sym "@module" },
    sym("@label")                        { Statement },

    sym("@string")                       { Constant },
    sym("@string.documentation")         { sym "@string" },
    sym("@string.regexp")                { Constant },
    sym("@string.escape")                { Special },
    sym("@string.special")               { Special },
    sym("@string.special.symbol")        { Identifier },
    sym("@string.special.url")           { sym "@string.special" },
    sym("@string.special.path")          { sym "@string.special" },

    sym("@character")                    { Constant },
    sym("@character.special")            { Special },

    sym("@boolean")                      { Boolean },
    sym("@number")                       { Number },
    sym("@number.float")                 { sym "@number" },

    sym("@type")                         { Type },
    sym("@type.builtin")                 { sym "@type" },
    sym("@type.definition")              { sym "@type" },
    sym("@type.qualifier")               { sym "@type" },

    sym("@attribute")                    { PreProc },
    sym("@property")                     { Identifier },

    sym("@function")                     { Function },
    sym("@function.builtin")             { Special },
    sym("@function.call")                { sym "@function" },
    sym("@function.macro")               { PreProc },

    sym("@function.method")              { sym "@function" },
    sym("@function.method.call")         { sym "@function" },

    sym("@constructor")                  { Special },
    sym("@operator")                     { Operator },

    sym("@keyword")                      { Keyword },
    sym("@keyword.coroutine")            { sym "@keyword" },
    sym("@keyword.function")             { sym "@keyword" },
    sym("@keyword.operator")             { sym "@keyword" },
    sym("@keyword.import")               { sym "@keyword" },
    sym("@keyword.storage")              { sym "@keyword" },
    sym("@keyword.repeat")               { sym "@keyword" },
    sym("@keyword.return")               { sym "@keyword" },
    sym("@keyword.debug")                { sym "@keyword" },
    sym("@keyword.exception")            { sym "@keyword" },

    sym("@keyword.conditional")          { sym "@keyword" },
    sym("@keyword.conditional.ternary")  { sym "@keyword.conditional" },
    sym("@keyword.directive")            { PreProc },
    sym("@keyword.directive.define")     { sym "@keyword.directive" },

    sym("@punctuation")                  { Delimiter },
    sym("@punctuation.delimiter")        { Delimiter },
    sym("@punctuation.bracket")          { Delimiter },
    sym("@punctuation.special")          { Delimiter },

    sym("@comment")                      { Comment },
    sym("@comment.documentation")        { sym "@comment" },

    sym("@comment.error")                { Error },
    sym("@comment.warning")              { WarningMsg },
    sym("@comment.todo")                 { Todo },
    sym("@comment.note")                 { DiagnosticInfo },

    sym("@markup.strong")                { Bold },
    sym("@markup.itailc")                { Italic },
    sym("@markup.strikethrough")         { gui = "strikethrough" },
    sym("@markup.underline")             { Underlined },

    sym("@markup.heading")               { Title },

    sym("@markup.quote")                 { Comment },
    sym("@markup.math")                  { Special },
    sym("@markup.environment")           { PreProc },

    sym("@markup.link")                  { Constant },
    sym("@markup.link.label")            { Special },
    sym("@markup.link.url")              { Constant, gui = "underline" },

    sym("@markup.raw")                   { Constant },
    sym("@markup.raw.block")             { sym "@markup.raw" },

    sym("@markup.list")                  { Special },
    sym("@markup.list.checked")          { sym "@markup.list" },
    sym("@markup.list.unchecked")        { sym "@markup.list" },

    sym("@diff.plus")                    { fg = colors.bright_green.sa(6).da(8) },
    sym("@diff.minus")                   { fg = colors.red },
    sym("@diff.delta")                   { fg = colors.blue },

    sym("@tag")                          { Special },
    sym("@tag.attribute")                { sym "@property" },
    sym("@tag.delimiter")                { Delimiter },

    sym("@none")                         { },

    sym("@punctuation.special.markdown") { Special },
    sym("@string.escape.markdown")       { SpecialKey },
    sym("@markup.link.markdown")         { Identifier, gui = "underline" },
    sym("@markup.italic.markdown")       { Italic },
    sym("@markup.title.markdown")        { Statement },
    sym("@markup.raw.markdown")          { Type },
    sym("@markup.link.url.markdown")     { SpecialComment },

    -- (SP Semantic Token Groups
    sym("@lsp.type.boolean")                       { sym "@boolean" },
    sym("@lsp.type.builtinType")                   { sym "@type.builtin" },
    sym("@lsp.type.comment")                       { sym "@comment" },
    sym("@lsp.type.decorator")                     { sym "@attribute" },
    sym("@lsp.type.deriveHelper")                  { sym "@attribute" },
    sym("@lsp.type.enum")                          { sym "@type" },
    sym("@lsp.type.enumMember")                    { sym "@constant" },
    sym("@lsp.type.escapeSequence")                { sym "@string.escape" },
    sym("@lsp.type.formatSpecifier")               { sym "@markup.list" },
    sym("@lsp.type.generic")                       { sym "@variable" },
    sym("@lsp.type.interface")                     { sym "@type" },
    sym("@lsp.type.keyword")                       { Statement },
    sym("@lsp.type.lifetime")                      { sym "@keyword.storage" },
    sym("@lsp.type.namespace")                     { sym "@module" },
    sym("@lsp.type.number")                        { sym "@number" },
    sym("@lsp.type.operator")                      { sym "@operator" },
    sym("@lsp.type.parameter")                     { sym "@variable.parameter" },
    sym("@lsp.type.property")                      { sym "@property" },
    sym("@lsp.type.selfKeyword")                   { sym "@variable.builtin" },
    sym("@lsp.type.selfTypeKeyword")               { sym "@variable.builtin" },
    sym("@lsp.type.string")                        { sym "@string" },
    sym("@lsp.type.typeAlias")                     { sym "@type.definition" },
    sym("@lsp.type.unresolvedReference")           { gui = "undercurl", sp = Error.fg },
    sym("@lsp.type.variable")                      { },
    sym("@lsp.typemod.class.defaultLibrary")       { sym "@type.builtin" },
    sym("@lsp.typemod.enum.defaultLibrary")        { sym "@type.builtin" },
    sym("@lsp.typemod.enumMember.defaultLibrary")  { sym "@constant.builtin" },
    sym("@lsp.typemod.function.defaultLibrary")    { sym "@function.builtin" },
    sym("@lsp.typemod.keyword.async")              { sym "@keyword.coroutine" },
    sym("@lsp.typemod.keyword.injected")           { Statement },
    sym("@lsp.typemod.macro.defaultLibrary")       { sym "@function.builtin" },
    sym("@lsp.typemod.method.defaultLibrary")      { sym "@function.builtin" },
    sym("@lsp.typemod.operator.injected")          { sym "@operator" },
    sym("@lsp.typemod.string.injected")            { sym "@string" },
    sym("@lsp.typemod.struct.defaultLibrary")      { sym "@type.builtin" },
    sym("@lsp.typemod.type.defaultLibrary")        { sym "@type" },
    sym("@lsp.typemod.typeAlias.defaultLibrary")   { sym "@type" },
    sym("@lsp.typemod.variable.callable")          { sym "@function" },
    sym("@lsp.typemod.variable.defaultLibrary")    { sym "@variable.builtin" },
    sym("@lsp.typemod.variable.injected")          { sym "@variable" },
    sym("@lsp.typemod.variable.static")            { sym "@constant" },

    diffAdded            { fg = colors.bright_green.sa(6).da(8) },
    diffRemoved          { fg = colors.red },
    diffChanged          { fg = colors.blue },
    diffOldFile          { diffRemoved, gui = "italic" },
    diffNewFile          { diffAdded, gui = "italic" },
    diffFile             { fg = colors.yellow, gui = "bold" },
    diffLine             { fg = colors.magenta, gui = "bold" },
    diffIndexLine        { fg = colors.yellow },

    gitcommitOverflow          { WarningMsg },
    gitcommitHeader            { Title },
    gitcommitSummary           { Title },

    markdownUrl               { SpecialComment },
    markdownCode              { Type },
    markdownLinkText          { Identifier, gui = "underline" },
    markdownLinkTextDelimiter { Delimiter },

    helpHyperTextEntry        { gui = "bold" },
    helpHyperTextJump         { Constant },
    helpSpecial               { Type },
    helpOption                { Constant, gui = "italic" },

    GitSignsAdd                      { SignColumn, fg = colors.bright_green },
    GitSignsChange                   { SignColumn, fg = colors.blue },
    GitSignsDelete                   { SignColumn, fg = colors.red },

    TelescopeSelection               { gui = "bold" },
    TelescopeSelectionCaret          { fg = colors.red },
    TelescopeMatching                { fg = colors.yellow, gui = "bold" },
    TelescopeBorder                  { VertSplit },

    CmpItemAbbr                      { fg = colors.bg.li(36) },
    CmpItemAbbrDeprecated            { fg = colors.bg.li(36), gui = "strikethrough" },
    CmpItemAbbrMatch                 { fg = colors.fg, gui = "bold" },
    CmpItemAbbrMatchFuzzy            { fg = colors.fg.da(12), gui = "bold" },
    CmpItemKind                      { fg = colors.bg.li(32) },
    CmpItemMenu                      { fg = colors.bg.li(28) },

    fugitiveHeader              { Statement },
    fugitiveHelpHeader          { Statement },
    fugitiveHunk                { fg = colors.fg.da(12) },

    typescriptParens            { fg = colors.fg },

    prrAdded { diffAdded },
    prrRemoved { diffRemoved },
    prrFile { Special },

    prrHeader { Directory },

    prrIndex { Special },
    prrChunk { Special },
    prrChunkH { Special },
    prrTagName { Special },
    prrResult { Special },

    User1               { Bold, bg = StatusLine.bg }
  }
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
