# myfitnesspal

Please write a method to normalize a string which represents a file path.

For the purposes of this question, normalizing means:

All single dot components of the path must be removed.  For example, "foo/./bar" should be normalized to "foo/bar".

All double dot components of the path must be removed, along with their parent directory.  For example, "foo/bar/../baz" should be normalized to "foo/baz".

For any paths starting with ".." string, assume you are in the root directory.  For example, "../foo/bar" normalizes to "/foo/bar".

That's it.  Normally, a path normalization algorithm would do a lot of other stuff, but for this question, don't try any other kind of normalization or transformation of the path.

Write your method in Objective-C.

The method should take in a string and return a string representing the normalized path. You may implement using standard libraries providing string or list functionality. DO NOT USE specialized path manipulation libraries or regular expressions, that would trivialize the problem.

Please write code that you feel proud of and would check in to source control in a professional environment. Thanks!
