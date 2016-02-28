**UIViews/NSLayoutConstraints Hierarchy Code Generator for Your iOS projects**

This tool allow to generate code for view/constraints hierarchy with views from Interface Builder (Storyboards or Xibs), designed for fast custom views prototype creation and easy changes in future. 

I like to use size classes for create differents design for various trait collections in IB. But for some case we can't use this methods (for example: reusable views, complex logic for constraints changes, independent from size classes, etc). For this case we need manualy create view hierarchy and create constraints for each views state, check some state and activate/deactivate specific constraints. Code for constraints creation becomes enormous and difficult to understand.

I like to create UI in Interface Builder, what if create all design in IB and translate all views/constraints to code analogs?

**Basic usage & example**

Let's say we need to create some user profile view to be used in different parts of the project. This view also have other design for portrait/landscape orientation or some other dependence. I create two view controllers with various design:

First:
![](https://raw.githubusercontent.com/rock88/iOS-View-Hierarchy-Code-Generator/assets/1.png)

Second:
![](https://raw.githubusercontent.com/rock88/iOS-View-Hierarchy-Code-Generator/assets/2.png)

Next need import to project `RCKViewHierarchyCodeGenerator` sources, and generate source code for first view controller.
```
#import "RCKViewHierarchyCodeGenerator.h"
...
- (void)viewDidLoad {
    [super viewDidLoad];
    
    RCKViewHierarchyCodeGenerator* generator = [[RCKViewHierarchyCodeGenerator alloc] initWithSuperView:self.view];
    generator.constraintsType = RCKConstraintsTypeMasonry;
    NSLog(@"%@", [generator sourceCode]);
}
```

Use `generator.constraintsType` for disable constraints or select preffered constraints framework, currently support next types:

`RCKConstraintsTypeNone` - don't create constraints, use current view.frame value;

`RCKConstraintsTypeUIKit` - create constraints with UIKit framework;

`RCKConstraintsTypeMasonry` - create constraints with Masonry framework (https://github.com/SnapKit/Masonry);

From log we can grab view creation code, add it to `-viewDidLoad`:

```
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView* superview = self.view; // Define superview
    
    UIView* container = [[UIView alloc] init];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    [superview addSubview:container];
    
    UIImageView* profileImage = [[UIImageView alloc] init];
    profileImage.translatesAutoresizingMaskIntoConstraints = NO;
    [container addSubview:profileImage];
    
    UIButton* changeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    changeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [changeButton setTitle:@"Change image" forState:UIControlStateNormal];
    [container addSubview:changeButton];
    
    UILabel* infoLabel = [[UILabel alloc] init];
    infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    infoLabel.text = @"Profile info";
    [container addSubview:infoLabel];
}
```

For define correct view names set accessibilityLabel for this view in IB. Next work with constraints, `RCKViewHierarchyCodeGenerator` generate constraints creation code (I use Masonry framework for minimalistic code). We need to save this constraints for future use, so add it to `portraitConstraints` array.

```
    self.portraitConstraints = [NSMutableArray array];
    [self.portraitConstraints addObjectsFromArray:[changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(profileImage.mas_bottom).with.offset(8.0f);
        make.leading.equalTo(container).with.offset(8.0f);
    }]];
    [self.portraitConstraints addObjectsFromArray:[container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(4.0f);
        make.bottom.equalTo(infoLabel).with.offset(8.0f);
        make.leading.equalTo(superview).with.offset(4.0f);
        make.trailing.equalTo(infoLabel).with.offset(8.0f);
        make.width.equalTo(@(220.0f));
        make.height.equalTo(@(180.0f));
    }]];
    [self.portraitConstraints addObjectsFromArray:[infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(container).with.offset(8.0f);
        make.leading.equalTo(changeButton.mas_trailing).with.offset(8.0f);
        make.leading.equalTo(profileImage.mas_trailing).with.offset(8.0f);
    }]];
    [self.portraitConstraints addObjectsFromArray:[profileImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(container).with.offset(8.0f);
        make.leading.equalTo(container).with.offset(8.0f);
        make.width.equalTo(@(120.0f));
        make.height.equalTo(@(120.0f));
    }]];
```

Now need generate constraints code for second view controller and add constraints to `landscapeConstraints` array.

```
    self.landscapeConstraints = [NSMutableArray array];
    [self.landscapeConstraints addObjectsFromArray:[changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(profileImage.mas_bottom);
        make.leading.equalTo(container).with.offset(8.0f);
    }]];
    [self.landscapeConstraints addObjectsFromArray:[container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).with.offset(4.0f);
        make.bottom.equalTo(infoLabel).with.offset(8.0f);
        make.leading.equalTo(superview).with.offset(4.0f);
        make.trailing.equalTo(profileImage).with.offset(8.0f);
        make.trailing.equalTo(changeButton).with.offset(8.0f);
        make.trailing.equalTo(infoLabel).with.offset(8.0f);
    }]];
    [self.landscapeConstraints addObjectsFromArray:[infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(changeButton.mas_bottom);
        make.leading.equalTo(container).with.offset(8.0f);
        make.height.equalTo(@(60.0f));
    }]];
    [self.landscapeConstraints addObjectsFromArray:[profileImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(container).with.offset(8.0f);
        make.leading.equalTo(container).with.offset(8.0f);
        make.width.equalTo(@(120.0f));
        make.height.equalTo(@(120.0f));
    }]];
    [self.landscapeConstraints makeObjectsPerformSelector:@selector(deactivate)];
```

Done! Now for changes design need to activate one constraints array and deactivate other.

```
- (void)updateUIDesign {
    if (some state) {
        [self.landscapeConstraints makeObjectsPerformSelector:@selector(deactivate)];
        [self.portraitConstraints makeObjectsPerformSelector:@selector(activate)];
    } else {
        [self.portraitConstraints makeObjectsPerformSelector:@selector(deactivate)];
        [self.landscapeConstraints makeObjectsPerformSelector:@selector(activate)];
    }
    
    [self.view setNeedsLayout];
}
```

For UIKit constraints `RCKViewHierarchyCodeGenerator` return code like

```
    NSArray* constraints =
    @[
      [NSLayoutConstraint constraintWithItem:changeButton
                                   attribute:NSLayoutAttributeTop
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:profileImage
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1.0f
                                    constant:0.0f],
      [NSLayoutConstraint constraintWithItem:changeButton
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:container
                                   attribute:NSLayoutAttributeLeading
                                  multiplier:1.0f
                                    constant:8.0f],
      ];
```

For activate/deactivate use
```
[NSLayoutConstraint activateConstraints:constraints];
// or
[NSLayoutConstraint deactivateConstraints:constraints];
```

**Limitation**

This tool not designed for use with containers like UITableView, UICollectionView, UIStackView. 

If you find bug or need to feature request, please create issues 🦄
