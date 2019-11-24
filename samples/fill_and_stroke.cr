require "gobject/gdk"
require "../src/cairo"
class CairoApp
  
  @window : Gdk::Window
  @main_loop : GLib::MainLoop
 
  def initialize
    Gdk.init

    @window = Gdk::Window.new(nil,
      Gdk::WindowAttr.new(
      title: "Simple Cairo Example",
      window_type: Gdk::WindowType::TOPLEVEL,
      wclass: Gdk::WindowWindowClass::INPUT_OUTPUT,
      width: 800,
      height: 600
      ),
      Gdk::WindowAttributesType.flags(TITLE)
      )
    
    @window.events = Gdk::EventMask::ZERO_NONE

    @main_loop=GLib::MainLoop.new(nil, true)
  end 
  
  def draw(context)
    context.line_width=9
    context.set_source_rgb( 0.69, 0.19, 0) 
    context.translate(400,300)
    context.arc(0,0,50,0,6.283)
    context.stroke_preserve
    context.set_source_rgb( 0.30, 0.40, 0.60)
    context.fill
  end 

  def run()
    @window.show
    Gdk::Event.on_event do |event|
      case event.event_type
        when Gdk::EventType::VISIBILITY_NOTIFY
          draw((Gdk.cairo_create(@window)))
        when Gdk::EventType::DELETE
          @main_loop.quit
      end
    end
    @main_loop.run
  end
end

app=CairoApp.new
app.run

 









