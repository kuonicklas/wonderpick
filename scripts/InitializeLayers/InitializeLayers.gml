function InitializeLayers(){
    global.Layers = {
        Gui : layer_create(-10, "GuiLayer"),
        Card : layer_create(-5, "CardLayer"),
        Main : layer_create(0, "MainLayer")
    }
}