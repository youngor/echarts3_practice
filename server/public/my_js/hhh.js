//app.title = '嵌套环形图';

option = {
    backgroundColor: '#ffffff',
    animation: false, // save image...
    legend: {
        orient: 'vertical',
        x: 'left',
        data:  ['2.0L','2.2L','2.3L','2.4L','3.0L','3.5L'] //['1.5L','1.6L','1.8L']
    },
    
    series: [
        {
            name:'本地过户量',
            type:'pie',
            selectedMode: 'single',
            radius: [0, '30%'],

            label: {
                normal: {
                    //formatter: '{a|{a}}{abg|}\n{hr|}\n  {b|{b}：}{c}  {per|{d}%}  ',
                    position: 'inner',
                    fontSize: 12
                }
            },
            labelLine: {
                normal: {
                    show: false
                }
            },
            
            data:
                [{value:15139,name:'2.0L'},{value:8,name:'2.2L'},{value:1650,name:'2.3L'},{value:12923,name:'2.4L'},{value:411,name:'3.0L'},{value:93,name:'3.5L'},] //[{value:5122, name:'1.5L'}, {value:29071, name:'1.6L'}]
                
            
        },
        {
            name:'外迁过户量',
            type:'pie',
            radius: ['45%', '70%'],

            label: {
                normal: {
                    //formatter: '{a|{a}}{abg|}\n{hr|}\n  {b|{b}：}{c}  {per|{d}%}  ',
                    position: 'inner',
                    fontSize: 16
                }
            },
            labelLine: {
                normal: {
                    show: false
                }
            },

            data: [{value:4592,name:'2.0L'},{value:298,name:'2.3L'},{value:4372,name:'2.4L'},{value:131,name:'3.0L'},{value:39,name:'3.5L'},] //[{value:5122, name:'1.5L'}, {value:29071, name:'1.6L'}]
        }
    ]
};