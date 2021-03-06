public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

//ref: https://leetcode.com/problems/binary-tree-pruning/solution/
class Solution {
    func pruneTree(_ root: TreeNode?) -> TreeNode? {
        prune(root)
        return root
    }
    
    @discardableResult
    private func prune(_ node: TreeNode?) -> Bool {
        guard let node = node else {
            return true
        }
        if prune(node.left) {
            node.left = nil
        }
        if prune(node.right) {
            node.right = nil
        }
        return node.val == 0 && node.left == nil && node.right == nil
    }
}

//iterative post-order sln.
//swift implementation of cpp version
class Solution2 {
    private class item {
        var node: TreeNode
        var toVisit = true
        var parent: TreeNode
        var dir: Bool //left: false, right: true
        
        init(_ node: TreeNode, _ parent: TreeNode, _ dir: Bool) {
            self.node = node
            self.parent = parent
            self.dir = dir
        }
    }
    
    func pruneTree(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else { return nil }
        let fake = TreeNode(-1); fake.left = root
        
        var stack = [item(root,fake,false)]
        
        while !stack.isEmpty {
            let top = stack.last!
            if top.toVisit {
                let tmp = top.node
                if (tmp.left != nil) {
                    stack.append(item(tmp.left!,tmp,false))
                }
                if (tmp.right != nil) {
                    stack.append(item(tmp.right!,tmp,true))
                }
                top.toVisit = false
            } else {
                let tmp = top.node
                if (tmp.left == nil && tmp.right == nil && tmp.val == 0) {
                    if top.dir {
                        top.parent.right = nil
                    } else {
                        top.parent.left = nil
                    }
                }
                stack.removeLast(1)
            }
        }
        
        return fake.left
    }
}
