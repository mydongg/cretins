'use strict';
 
var gulp = require('gulp');
var sass = require('gulp-sass');
 
sass.compiler = require('node-sass');
 
gulp.task('scss', function scss() {
 	return gulp.src('template/css/main.scss')
	    .pipe(sass().on('error', sass.logError))
	    .pipe(gulp.dest('dist/css'));
});

gulp.task('js', function js() {
	return gulp.src('template/js/*.js')
	    .pipe(gulp.dest('dist/js'));
})

gulp.task('img', function img() {
	return gulp.src('template/src/*.*')
	    .pipe(gulp.dest('dist/src'));
})


gulp.task('watch', function() {
	gulp.watch('template/css/*.scss', gulp.series('scss'));
	gulp.watch('template/js/*.js', gulp.series('js'));
	gulp.watch('template/src/*.*', gulp.series('img'));

});

var defolt = gulp.series('scss', 'js', 'img');
gulp.task('default', defolt);
