## JMSlider

JMSlider is a sliding component that can be used to toggle three actions with a single button.  For example, it can be used to allow for multiple actions at the end of lists/tables while keeping visual clutter to a minimum.  The component is rendered entirely using **Core Graphics** so it does not require any additional images to be used in your projects.

## How it looks

This is what JMSlider looks like out of the box, (or a [video](http://youtu.be/GV40mAwcCrI?hd=1) if you prefer):

<img src="http://alienblue.org/github/JMSlider-sequence.png" width=349 height=900 />

## Usage

A demo project is included in the repository so that you can give it a test drive.  In brief, this is all you need to create the slider:

`JMSlider *slider = [JMSlider sliderWithFrame:sliderFrame centerTitle:@"more" leftTitle:@"hide read" rightTitle:@"hide all" delegate:self];`

By implementing the `slider:didSelect:` method, you will receive a callback when the tab selection changes.

## Flexibility

JMSlider also supports the execution of blocks so that you can embed your logic inline, like this:

`[slider setLeftExecuteBlock:^{
    // do stuff after left option has been selected
}];`

## Loading Indicator

The slider has a built-in activity indicator for convenience.  To turn the activity indicator on:

`[slider setLoading:YES];`

The Demo project included also demonstrates how this can be used in your code.

## Embedding in Table/ScrollViews

If you embed the slider in a tableView (e.g. in a UITableViewCell) be sure to call:

`[tableView setCanCancelContentTouches:NO];`

This will prevent the table/scrollView from scrolling vertically while the user is pressing down on the slider, which leads to a much better user experience.

## Customisation

You can subclass any of the slider's internal components, and then implement any/all of the following methods in your delegate:

`-(JMCenterView *)sliderCenterViewForSlider:(JMSlider *)slider`

`-(JMSideView *)sliderLeftViewForSlider:(JMSlider *)slider`

`-(JMSideView *)sliderRightViewForSlider:(JMSlider *)slider`

`-(JMSliderTrack *)sliderTrackViewForSlider:(JMSlider *)slider`

For example, Alien Blue subclasses JMCenterView to draw a dark version of the toggle in Night Mode.

## Acknowledgements

This project uses the UIView+Positioning and UIView+Size categories developed by the very talented [Kevin O'Neill](https://github.com/kevinoneill/Useful-Bits).

## License

JMSlider is BSD licensed, so you can freely use it in commercial applications.
